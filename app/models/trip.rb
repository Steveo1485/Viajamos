class Trip < ActiveRecord::Base
  belongs_to :user

  has_many :destinations, inverse_of: :trip
  has_many :locations, through: :destinations

  accepts_nested_attributes_for :destinations, reject_if: proc { |attributes| attributes['location_id'].blank? }

  validates :user_id, numericality: true
  validates :time_period, inclusion: { in: Proc.new{ Trip.time_period_options } }
  validates :certainty, inclusion: { in: Proc.new{ Trip.certainty_options } }, if: Proc.new{ |trip| trip.time_period == 'future'}
  validates :purpose, inclusion: { in: Proc.new{ Trip.purpose_options } }, allow_nil: true
  validates :start_date, presence: true, if: :booked?
  validates :end_date, presence: true, if: :booked?

  scope :wishlist, -> { where(time_period: 'wishlist') }
  scope :past, -> { where(time_period: "past" ) }
  scope :upcoming, -> { where(time_period: "future") }

  def self.time_period_options
    ["past", "future", "wishlist"]
  end

  def self.certainty_options
    ["booked", "likely", "possible"]
  end

  def self.purpose_options
    ["work", "leisure", "other"]
  end

  def self.purpose_options_for_select
    purpose_options.map { |option| [option.titleize, option] }
  end

  def set_dates?
    start_date.present? && end_date.present?
  end

  def date_range
    if set_dates?
      "#{start_date.strftime('%e %b %Y')} - #{end_date.strftime('%e %b %Y')}"
    else
      "No date set for trip"
    end
  end

  def cities
    locations.pluck(:city)
  end

  def friend_overlaps
    @friend_overlaps ||= destinations.map { |d| d.friend_overlaps }.flatten.map { |d| d.trip }.uniq
  end

  def any_overlaps?
    friend_overlaps.any?
  end

  def booked?
    certainty == 'booked'
  end
end