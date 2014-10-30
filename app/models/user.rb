class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, dependent: :destroy

  after_create :check_facebook_friends, if: Proc.new{ |user| user.oauth_token.present? }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.oauth_token = auth.credentials.token
      user.oauth_token_expires_at = auth.credentials.expires_at
    end
  end

  def name
    (first_name or last_name) ? [first_name, last_name].join(" ") : email
  end

  def outstanding_friend_requests
    friendships.where(confirmed: false)
  end

  def friend_requests
    Friendship.where(friend_id: self.id, confirmed: false)
  end

  def travel_buddies
    User.where(id: friendships.where(type: "TravelBuddy", confirmed: true).pluck(:friend_id))
  end

  def friends
    User.where(id: friendships.where(type: "Friend", confirmed: true).pluck(:friend_id))
  end

  def friends_with?(user)
    friends.include?(user) || travel_buddies.include?(user)
  end

  def travel_buddies_with?(user)
    travel_buddies.include?(user)
  end

  def friend_of_friend_with?(user)
    friends.each do |friend|
      if friend.friends.include?(user)
        return true
      end
    end
    false
  end

  def travel_buddy_of_travel_buddy_with?(user)
    travel_buddies.each do |travel_buddy|
      if travel_buddy.travel_buddies.include?(user)
        return true
      end
    end
    false
  end

  private

  def check_facebook_friends
    graph = Koala::Facebook::API.new(self.oauth_token, ENV['FACEBOOK_APP_SECRET'])
    friends = graph.get_connections("me", "friends")
    friends.each do |friend|
      # BUILD FACEBOOK ALERT
    end
  end
  handle_asynchronously :check_facebook_friends

end
