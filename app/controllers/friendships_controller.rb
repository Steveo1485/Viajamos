class FriendshipsController < ApplicationController
  before_filter :fetch_friendship, only: [:accept, :destroy, :block, :facebook_request]

  def find_friends
    @friendship = Friendship.new
    authorize(@friendship)

    @requested_user = User.where(email: params[:requested_friend_email]).first

    unless @requested_user
      flash[:notice] = "Sorry, no user was found with that email."
      redirect_to planner_path and return
    end

    if @requested_user.email == current_user.email
      flash[:notice] = "Sorry, you can't add yourself as a friend."
      redirect_to planner_path and return
    end

    if current_user.friendships.where(friend_id: @requested_user.id).first
      flash[:notice] = "There is alraedy an existing friendship or request for that user."
      redirect_to planner_path and return
    end
  end

  def create
    @friendship = Friendship.new(friendship_params)
    @friendship.user_id = current_user.id
    authorize(@friendship)

    if @friendship.save
      redirect_to planner_path, notice: "Friends request sent!"
    else
      @requested_user = User.find(friendship_params[:friend_id])
      render :find_friends
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

  def facebook_request
    authorize(@friendship)
    if @friendship.update(type: friendship_params[:type])
      @friendship.reverse_friendship.destroy if @friendship.reverse_friendship
      redirect_to planner_path, notice: "Friend request sent!"
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