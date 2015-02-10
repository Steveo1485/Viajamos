FactoryGirl.define do
  factory :trip do
    user
    time_period "future"
    purpose "work"
    certainty "booked"
    private :false
    busy :false
    departure_date {Faker::Date.forward(14)}

    trait :with_destination do
      before(:create) do |trip|
        trip.destinations << create(:destination, trip: trip, end_date: trip.departure_date)
      end
    end
  end
end