FactoryGirl.define do
  factory :destination do
    trip
    location
    start_date {Faker::Date.forward(7)}
  end
end
