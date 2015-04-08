class Destination < ActiveRecord::Base
  belongs_to :trip
  belongs_to :location

  validates :trip, presence: true
  validates :location, presence: true
  validates :day_offset, presence: true

  def self.day_order
    order(day_offset: :asc)
  end

  def user
    trip.user
  end

  def start_date
    @start_date ||= trip.start_date + day_offset.days
  end

  def end_date
    index =trip.destinations.day_order.index(self)
    if trip.destinations[index + 1]
      trip.destinations[index + 1].start_date
    else
      trip.end_date
    end
  end

  def friend_overlaps
    @friend_overlaps ||= Destination.joins(:trip).where('destinations.location_id': self.location.id,
                                                        'destinations.start_date': start_date..end_date,
                                                        'trips.user_id': user.friends.pluck(:id))
  end

  def any_overlaps?
    friend_overlaps.any?
  end
end