class Friendship < ActiveRecord::Base
  belongs_to :user

  validates :type, inclusion: { in: Proc.new{ Friendship.types } }
  validates :user_id, numericality: true
  validates :friend_id, numericality: true
  validates :user_id, uniqueness: { scope: :friend_id }

  after_create :update_facebook_connections

  after_update :create_reverse_friendship, if: Proc.new { |friendship| friendship.confirmed_changed? && friendship.confirmed }
  after_update :block_reverse_friendship, if: Proc.new{ |friendship| friendship.type_changed? && friendship.type == "Blocked" }

  def self.types
    ["Friend", "Blocked"]
  end

  def friend_user
    User.where(id: friend_id).first
  end

  def reverse_friendship
    Friendship.where(user_id: self.friend_id, friend_id: self.user_id).first
  end

  def find_friend(email, uid)
    found_friend = nil
    found_friend = User.where(email: email).first if email.present?
    found_friend ||= User.where(uid: uid).first if uid.present?
    self.friend_id = found_friend.id if found_friend
  end

  private

  def update_facebook_connections
    if connection = FacebookConnection.where(user_id: self.user_id, friend_user_id: self.friend_id).first
      connection.update(request_sent: true)
      connection.reverse_connection.update(request_sent: true)
    end
  end

  def create_reverse_friendship
    Friendship.create(user_id: self.friend_id, friend_id: self.user_id, type: self.type, confirmed: true)
  end

  def block_reverse_friendship
    reverse_friendship.update(type: "Blocked")
  end
end