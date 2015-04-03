FactoryGirl.define do
  factory :trip do
    user
    time_period "future"
    purpose "work"
    certainty "booked"
    private :false
    busy :false
    departure_date {Date.today + 14.days}

    trait :with_destination do
      before(:create) do |trip|
        trip.destinations << create(:destination, trip: trip, end_date: trip.departure_date)
      end
    end
  end
end