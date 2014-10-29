class FriendshipsController < ApplicationController
  before_filter :fetch_friendship, only: [:accept, :destroy, :block]
  skip_after_action :verify_authorized, only: [:find_friends, :create, :destroy, :accept, :block]

  def find_friends
    @friendship = Friendship.new
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
    if @friendship.save
      redirect_to planner_path, notice: "Friends request sent!"
    else
      @requested_user = User.find(friendship_params[:friend_id])
      render :find_friends
    end
  end

  def accept
    @friendship.confirmed = true
    if @friendship.save
      redirect_to planner_path, notice: "Friendship confirmed!"
    else
      redirect_to planner_path, notice: "Unable to confirm friendship. Please try again."
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to planner_path, notice: @friendship.destroy_flash
    else
      redirect_to planner_path, notice: "Unable to remove friend request. Please try again."
    end
  end

  def block
    @friendship.transaction do
      @friendship.type = "Blocked"
      @friendship.save!

      reverse_friendship = @friendship.reverse_friendship
      reverse_friendship.type = "Blocked"
      reverse_friendship.save!
    end
    redirect_to planner_path, notice: "User has been blocked."
  end

  private

  def friendship_params
    params.require(:friendship).permit(:type, :friend_id)
  end

  def fetch_friendship
    @friendship = Friendship.find(params[:id])
  end
end