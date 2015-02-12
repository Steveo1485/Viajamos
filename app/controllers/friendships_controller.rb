class FriendshipsController < ApplicationController
  before_filter :fetch_friendship, only: [:update, :destroy, :facebook_request]

  def create
    @friendship = Friendship.new(user_id: current_user.id, type: "Friend")
    authorize(@friendship)
    friend_user = @friendship.find_friend(params[:friend_email], params[:uid])
    redirect_to planner_path, notice: "Sorry, unable to find find." and return unless @friendship.friend_id
    if @friendship.save
      FriendshipMailer.delay.friend_request(@friendship)
      redirect_to planner_path, notice: "Friend request sent!"
    else
      redirect_to planner_path, notice: "Unable to send friend request. Please try again."
    end
  end

  def update
    authorize(@friendship)
    if @friendship.update(friendship_params)
      redirect_to planner_path, notice: "#{@friendship.type == 'Blocked' ? 'User has been blocked' : 'Friendship confirmed!'}"
    else
      redirect_to planner_path, notice: "Unable to process. Please try again."
    end
  end

  def destroy
    authorize(@friendship)
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to planner_path, notice: "Friendship successfully removed."
    else
      redirect_to planner_path, notice: "Unable to remove friend request. Please try again."
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:type, :friend_id, :confirmed)
  end

  def fetch_friendship
    @friendship = Friendship.find(params[:id])
  end
end