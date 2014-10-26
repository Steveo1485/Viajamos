class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }
  validates :user_id, numericality: true
  validates :friend_id, numericality: true
  validates :user_id, uniqueness: { scope: :friend_id }

  after_update :create_mirror_friendship, if: Proc.new { |friendship| friendship.confirmed_changed? && friendship.confirmed }

  def self.types
    ["Friend", "TravelBuddy"]
  end

  def destroy_flash
    confirmed ? "Friendship removed." : "Friend request declined."
  end

  private

  def create_mirror_friendship
    Friendship.create(user_id: self.friend_id, friend_id: self.user_id, type: self.type, confirmed: true)
  end
end