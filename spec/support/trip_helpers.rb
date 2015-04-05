def create_friend_overlap(trip, days_ahead = 1)
  friend = FactoryGirl.create(:friendship, user: trip.user, confirmed: true).friend_user
  overlap_trip = FactoryGirl.create(:trip, :with_destination, user: friend)
  destination = overlap_trip.destinations.last
  destination.location_id = trip.locations.first.id
  destination.start_date = trip.start_date + days_ahead.days
  destination.end_date = trip.end_date + days_ahead.days
  destination.save
  return overlap_trip
end