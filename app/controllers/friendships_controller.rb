class FriendshipsController < ApplicationController
  before_filter :fetch_friendship, only: [:update, :destroy]

  def create
    @friendship = Friendship.new(user_id: current_user.id, type: "Friend")
    authorize(@friendship)
    @friendship.friend_id = User.find_by_email_or_uid(params[:friend_email], params[:uid]).try(:id)
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