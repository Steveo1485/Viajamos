class FriendshipsController < ApplicationController
  before_filter :fetch_friendship, only: [:accept, :destroy, :block, :facebook_request]

  def create
    @friendship = Friendship.new(user_id: current_user.id, type: "Friend")
    authorize(@friendship)
    friend_user = User.where(email: params[:friend_email]).first || User.where(uid: params[:uid]).first
    redirect_to planner_path, notice: "Sorry, unable to find find." unless friend_user
    @friendship.friend_id = friend_user.id
    if @friendship.save
      redirect_to planner_path, notice: "Friend request sent!"
    else
      redirect_to planner_path, notice: "Unable to send friend request. Please try again."
    end
  end

  def accept
    authorize(@friendship)
    @friendship.confirmed = true
    if @friendship.save
      redirect_to planner_path, notice: "Friendship confirmed!"
    else
      redirect_to planner_path, notice: "Unable to confirm friendship. Please try again."
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

  def block
    authorize(@friendship)
    @friendship.type = "Blocked"
    if @friendship.save
      redirect_to planner_path, notice: "User has been blocked."
    else
      redirect_to planner_path, notice: "Sorry, we weren't able to process that. Please try again."
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:type, :friend_id)
  end

  def fetch_friendship
    @friendship = Friendship.find(params[:id])
  end
end