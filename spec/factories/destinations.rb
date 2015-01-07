FactoryGirl.define do
  factory :destination do
    trip
    location
    start_date {Faker::Date.forward(7)}
    end_date {Faker::Date.forward(14)}
  end
end
