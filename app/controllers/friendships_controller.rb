class FriendshipsController < ApplicationController
  skip_after_action :verify_authorized, only: [:find_friends, :create]

  def find_friends
    @friendship = Friendship.new
    @requested_user = User.where(email: params[:requested_friend_email]).first
    unless @requested_user
      flash[:notice] = "Sorry, no user was found with that email."
      redirect_to planner_path and return
    end
    redirect_to planner_path, notice: "Sorry, you can't add yourself as a friend." if @requested_user.email == current_user.email
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id
    if @friendship.save
      redirect_to planner_path, notice: "Friends request sent!"
    else
      @requested_user = User.find(friendship_params[:friend_id])
      render :find_friends
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:type, :friend_id)
  end
end