class Trip < ActiveRecord::Base
  belongs_to :location

  validates :location_id, numericality: true
  validates :user_id, numericality: true
  validates :start_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
  validates :end_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
end