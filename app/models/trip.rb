class Trip < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  validates :location_id, numericality: true
  validates :user_id, numericality: true
  validates :start_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
  validates :end_date, presence: true, if: Proc.new { |trip| trip.certainty == 'booked'}
  validates :certainty, inclusion: { in: Proc.new{ Trip.certainty_options } }
  validates :purpose, inclusion: { in: Proc.new{ Trip.purpose_options } }, allow_nil: true

  scope :wishlist, -> { where(certainty: 'wishlist') }
  scope :past, -> { where(certainty: "been" ) }
  scope :upcoming, -> { where(certainty: ["going", "booked", "likely", "possible"]) }

  def self.certainty_options
    ["been", "going", "wishlist", "booked", "likely", "possible"]
  end

  def self.purpose_options
    ["business", "vacation", "other"]
  end

  def self.purpose_options_for_select
    purpose_options.map { |option| [option.titleize, option] }
  end

  def date_range
    if start_date && end_date
      "#{start_date.strftime('%e %b %Y')} - #{end_date.strftime('%e %b %Y')}"
    else
      "No date set for trip"
    end
  end

end