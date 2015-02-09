FactoryGirl.define do
  factory :trip do
    user
    time_period "future"
    purpose "work"
    certainty "booked"
    private :false
    busy :false
    departure_date {Faker::Date.forward(14)}
  end
end