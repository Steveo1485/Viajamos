FactoryGirl.define do
  factory :facebook_connection do
    user
    friend_user_id {FactoryGirl.create(:user).id}
  end
end
