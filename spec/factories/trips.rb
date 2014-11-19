FactoryGirl.define do
  factory :trip do
    user
    location
    start_date {Faker::Date.forward(7)}
    end_date {Faker::Date.forward(14)}
    time_period "future"
    purpose "work"
    certainty "booked"
    private :false
    busy :false
  end
end
