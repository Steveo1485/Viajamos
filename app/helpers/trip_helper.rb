module TripHelper

  def trip_facebook_feed_caption(trip)
    if trip.set_dates?
      "I'm going to be in #{trip.cities} from #{trip.date_range}. Who wants to hang out? #cotripping"
    else
      "I'm going to #{trip.cities}. Who wants to hang out? #cotripping"
    end
  end

end