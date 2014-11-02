FactoryGirl.define do
  factory :friendship do
    user
    friend_id {FactoryGirl.create(:user).id}
    type "TravelBuddy"
    confirmed false
  end
end
