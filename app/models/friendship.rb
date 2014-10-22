class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }

  def self.types
    ["friend", "travel_buddy", "buddy_of_buddy", "friend_of_friend"]
  end
end