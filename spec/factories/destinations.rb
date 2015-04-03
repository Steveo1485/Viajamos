FactoryGirl.define do
  factory :destination do
    trip
    location
    start_date {Date.today + 7.days}
  end
end
