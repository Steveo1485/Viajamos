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
  end
end