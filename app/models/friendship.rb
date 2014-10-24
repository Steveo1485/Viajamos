class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }
  validates :user_id, numericality: true
  validates :friend_id, numericality: true

  def self.types
    ["Friend", "TravelBuddy"]
  end
end