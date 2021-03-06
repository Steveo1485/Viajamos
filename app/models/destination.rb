class Destination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :location

  validates :trip, presence: true
  validates :location_id, presence: true
  validate :start_date_if_booked
  validate :end_date_if_booked

  before_validation :set_end_date

  private

  def set_end_date
    self_index = trip.destinations.find_index(self) || 0
    if trip.destinations[self_index + 1]
      end_date = trip.destinations[self_index + 1].start_date
    else
      self.end_date = trip.departure_date
    end
  end

  def start_date_if_booked
    if self.trip and self.trip.certainty == "booked" and start_date.blank?
      errors.add(:start_date, "must be provided for booked trips")
    end
  end

  def end_date_if_booked
    if self.trip and self.trip.certainty == "booked" and end_date.blank?
      errors.add(:end_date, "must be provided for booked trips")
    end
  end
end