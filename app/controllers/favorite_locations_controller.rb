class FavoriteLocationsController < ApplicationController

  def new
    @favorite_location = FavoriteLocation.new(user_id: current_user.id)
    authorize(@favorite_location)
  end

  def create
    @favorite_location = FavoriteLocation.new(favorite_location_params.merge(user_id: current_user.id))
    authorize(@favorite_location)
    if @favorite_location.save
      redirect_to new_favorite_location_path, notice: "Successfully added favorite location!"
    else
      render :new
    end
  end

  def destroy
    @favorite_location = FavoriteLocation.find(params[:id])
    authorize(@favorite_location)
    if @favorite_location.destroy
      flash[:notice] = "Favorite location successfully removed."
    else
      flash[:notice] = "Unable to remove favorite location. Please try again."
    end
    redirect_to new_favorite_location_path
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:location_id)
  end
end