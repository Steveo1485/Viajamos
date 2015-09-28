class Destination < ActiveRecord::Base

  belongs_to :location
  belongs_to :trip

  validates :trip, presence: true
  validates :location, presence: true

  def user
    trip.user
  end

end