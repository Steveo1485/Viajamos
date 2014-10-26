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
    friendships.where(type: "TravelBuddy", confirmed: true)
  end

  def friends
    friendships.where(type: "Friend", confirmed: true)
  end
end
