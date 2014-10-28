class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
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

  def friend_of_friends_with?(user_id)
    friends.each do |friend|
      if friend.friend_user.friends.pluck(:friend_id).include?(user_id)
        return true
      end
    end
    false
  end

  def travel_buddy_of_travel_buddy_with?(user_id)
    travel_buddies.each do |travel_buddy|
      if travel_buddy.friend_user.travel_buddies.pluck(:friend_id).include?(friend_id)
        return true
      end
    end
    false
  end
end
