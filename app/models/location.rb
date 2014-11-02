class Location < ActiveRecord::Base
  validates :city, presence: true
  validates :country_code, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  def name
    [city, state_code, country_code].compact.join(", ")
  end
end