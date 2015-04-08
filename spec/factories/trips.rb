FactoryGirl.define do
  factory :trip do
    user
    time_period "future"
    purpose "work"
    certainty "booked"
    private :false
    busy :false
    start_date {Date.today + 7.days}
    end_date {Date.today + 14.days}

    factory :trip_with_destinations do
      transient do
        destinations_count 1
      end

      after(:create) do |trip, evaluator|
        create_list(:destination, evaluator.destinations_count, trip: trip)
      end
    end
  end
end