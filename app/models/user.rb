class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :friendships, dependent: :destroy
  has_many :favorite_locations
  has_many :trips, dependent: :destroy

  belongs_to :home_location, class_name: "Location", foreign_key: :home_location_id

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
    friendships.where(type: "Friend", confirmed: false)
  end

  def friend_requests
    Friendship.where(friend_id: self.id, type: "Friend", confirmed: false)
  end

  def friends
    User.where(id: friendships.where(type: "Friend", confirmed: true).pluck(:friend_id))
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def oauth?
    self.provider.present? and self.uid.present?
  end

  def past_trips
    trips.where(time_period: "past")
  end

  def city_count
    locations = past_trip_location_ids + favorite_location_ids
    locations.uniq.count
  end

  def country_count
    country_codes = favorite_location_country_codes + past_trip_country_codes
    country_codes.uniq.count
  end

  def world_domination
    country_count / Location::TOTAL_COUNTRIES
  end

  def favorite_cities
    favorites = favorite_locations.map { |favorite_location| favorite_location.location.city }
    favorites = ["No favorite locations."] if favorites.empty?
    favorites
  end

  private

  def favorite_location_ids
    favorite_locations.pluck(:location_id)
  end

  def favorite_location_country_codes
    favorite_locations.joins(:location).pluck(:country_code)
  end

  def past_trip_location_ids
    past_trips.map{ | trip| trip.locations.pluck(:id) }
  end

  def past_trip_country_codes
    past_trips.map{ | trip| trip.locations.pluck(:country_code) }
  end
end
