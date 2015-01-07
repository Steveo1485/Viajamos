class Destination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :location

  validates :trip_id, presence: true
  validates :location_id, presence: true
  validate :start_date_if_booked
  validate :end_date_if_booked


  private

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