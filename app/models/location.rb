class Location < ActiveRecord::Base
  TOTAL_COUNTRIES = 196.0

  has_many :favorite_locations
  has_many :users, through: :favorite_locations
  has_many :destinations
  has_many :trips, through: :destinations

  validates :city, presence: true
  validates :country_code, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :city, uniqueness: {scope: :country_code}

  def self.search(query)
    search_term = query.to_s.strip.split
    cached_all.where(['city LIKE ?', "%#{query}%"])
  end

  def self.cached_all
    @latest_update ||= Location.maximum(:updated_at).to_i
    Rails.cache.fetch(['Location.all', @latest_update]) do
      Location.all
    end
  end

  def name
    [city, state_code, country_code].compact.join(", ")
  end
end