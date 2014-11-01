class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }
  validates :user_id, numericality: true
  validates :friend_id, numericality: true
  validates :user_id, uniqueness: { scope: :friend_id }

  after_update :create_reverse_friendship, if: Proc.new { |friendship| friendship.confirmed_changed? && friendship.confirmed }
  after_update :block_reverse_friendship, if: Proc.new{ |friendship| friendship.type_changed? && friendship.type == "Blocked" }

  def self.types
    ["Friend", "TravelBuddy", "Blocked", "FacebookConnection"]
  end

  def destroy_flash
    confirmed ? "Friendship removed." : "Friend request declined."
  end

  def friend_user
    User.where(id: friend_id).first
  end

  def reverse_friendship
    Friendship.where(user_id: self.friend_id, friend_id: self.user_id).first
  end

  private

  def create_reverse_friendship
    Friendship.create(user_id: self.friend_id, friend_id: self.user_id, type: self.type, confirmed: true)
  end

  def block_reverse_friendship
    reverse_friendship.update(type: "Blocked")
  end
end