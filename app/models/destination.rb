class Destination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :location

  validates :trip, presence: true
  validates :location, presence: true

  def user
    trip.user
  end

end