class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }

  def self.types
    ["friend", "travel-buddy", "travel-buddy-of-travel-buddy", "friend-of-friend"]
  end
end