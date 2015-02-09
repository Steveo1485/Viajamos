FactoryGirl.define do
  factory :friendship do
    user
    friend_id {FactoryGirl.create(:user).id}
    type "Friend"
    confirmed false
  end
end
