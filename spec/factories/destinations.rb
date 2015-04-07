FactoryGirl.define do
  factory :destination do
    trip
    location
    day_offset 0
  end
end
