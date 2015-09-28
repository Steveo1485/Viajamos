def create_friend(user = nil)
  user ||= FactoryGirl.create(:user)
  FactoryGirl.create(:friendship, user: user, confirmed: true).friend_user
end