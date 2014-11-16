class Trip < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  validates :location_id, numericality: true
  validates :user_id, numericality: true
  validates :start_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
  validates :end_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
  validates :certainty, inclusion: { in: Proc.new{ Trip.certainty_options } }
  validates :purpose, inclusion: { in: Proc.new{ Trip.purpose_options } }, allow_nil: true

  def self.certainty_options
    ["i've been", "i'm going", "wishlist", "booked", "likely", "possible"]
  end

  def self.purpose_options
    ["business", "vacation", "other"]
  end

  def self.options_for_select
    purpose_options.map { |option| [option.titleize, option] }
  end

end