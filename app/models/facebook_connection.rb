class FacebookConnection < Friendship

  def self.create_connections(user)
    graph = Koala::Facebook::API.new(user.oauth_token, ENV['FACEBOOK_APP_SECRET'])
    friends = graph.get_connections("me", "friends")
    friends.each do |friend|
      uid = friend["id"]
      found_user = User.where(uid: uid).first
      if found_user
        FacebookConnection.create(user_id: user.id, friend_id: found_user.id)
        FacebookConnection.create(user_id: found_user.id, friend_id: user.id)
      end
    end
  end
end