FactoryGirl.define do
  factory :location do
    city {Faker::Address.city}
    state_code {Faker::Address.state_abbr}
    country_code "US"
    longitude {Faker::Address.longitude}
    latitude {Faker::Address.latitude}
  end
end
