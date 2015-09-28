def create_friend(user = nil)
  user ||= FactoryGirl.create(:user)
  FactoryGirl.create(:friendship, user: user, confirmed: true).friend_user
end

def create_confirmed_friendship(user, friend_user)
  FactoryGirl.create(:friendship, type: "Friend", user: user, friend_id: friend_user.id, confirmed: true)
end

def create_unconfirmed_friendship(user, friend_user)
  FactoryGirl.create(:friendship, user: user, friend_id: friend_user.id)
end