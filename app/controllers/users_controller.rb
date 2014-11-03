class UsersController < ApplicationController
  before_filter :fetch_user, only: [:show, :edit, :update]

  def show
    authorize(@user)
  end

  def edit
    authorize(@user)
  end

  def update
    authorize(@user)

    if @user.oauth? == false and @user.update_with_password(user_params)
      sign_in(@user, bypass: true)
      redirect_to edit_user_path(@user), notice: "Account settings successfully updated."
    elsif @user.oauth? and @user.update_attributes(user_params)
      sign_in(@user, bypass: true)
      redirect_to edit_user_path(@user), notice: "Account settings successfully updated."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :home_location_id, :password, :password_confirmation, :current_password)
  end

  def fetch_user
    @user = User.find(params[:id])
  end

end