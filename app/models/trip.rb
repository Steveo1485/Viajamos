class Trip < ActiveRecord::Base
  TIME_PERIODS = ["past", "future", "wishlist"]
  CERTAINTIES = ["booked", "possible"]
  PURPOSES = ["work", "leisure", "other"]

  belongs_to :user

  has_many :destinations, inverse_of: :trip
  has_many :locations, through: :destinations

  accepts_nested_attributes_for :destinations, reject_if: proc { |attributes| attributes['location_id'].blank? }

  validates :user_id, numericality: true
  validates :time_period, inclusion: { in: TIME_PERIODS }
  validates :certainty, inclusion: { in: CERTAINTIES }
  validates :purpose, inclusion: { in: PURPOSES }
  validates :start_date, presence: true, if: :booked?
  validates :end_date, presence: true, if: :booked?

  scope :wishlist, -> { where(time_period: 'wishlist') }
  scope :past, -> { where(time_period: "past" ) }
  scope :upcoming, -> { where(time_period: "future") }


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
    @friend_overlaps ||= Trip.where(user_id: user.friends.select{ |u| u.id }, start_date: start_date..end_date)
  end

  def any_overlaps?
    friend_overlaps.any?
  end

  def booked?
    certainty == 'booked'
  end
end