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

  def friend_destinations
    @friend_destinations ||= Destination.joins(:trip).where("trips.user_id": user.friends.pluck(:id))
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
    @friend_overlaps ||= friend_destinations.select { |d| (self.start_date..self.end_date).include?(d.start_date) }
  end

  def any_overlaps?
    friend_overlaps.any?
  end
end