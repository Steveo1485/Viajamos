class FacebookConnection < ActiveRecord::Base
  belongs_to :user

  validates :user_id, numericality: true
  validates :friend_user_id, numericality: true
  validates :friend_user_id, uniqueness: { scope: :user_id, message: "already a Facebook Connection." }

  scope :active, -> { where(request_sent: false, ignore: false) }

  def self.create_connections!(user)
    graph = Koala::Facebook::API.new(user.oauth_token, ENV['FACEBOOK_APP_SECRET'])
    friends = graph.get_connections("me", "friends")
    friends.each do |friend|
      found_user = User.where(uid: friend["id"]).first
      if found_user
        FacebookConnection.create(user_id: user.id, friend_user_id: found_user.id)
        FacebookConnection.create(user_id: found_user.id, friend_user_id: user.id)
      end
    end
  end

  def reverse_connection
    FacebookConnection.where(user_id: self.friend_user_id, friend_user_id: self.user_id).first
  end

  def friend_user
    User.where(id: friend_user_id).first
  end

  def ignored?
    ignore
  end
end