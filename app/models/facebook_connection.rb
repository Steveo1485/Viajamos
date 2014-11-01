class FacebookConnection < Friendship

  def self.create_connections(user)
    graph = Koala::Facebook::API.new(user.oauth_token, ENV['FACEBOOK_APP_SECRET'])
    friends = graph.get_connections("me", "friends")
    friends.each do |friend|
      uid = friend["id"]
      found_user = User.where(uid: uid).first
      FacebookConnection.create(user_id: user.id, friend_id: found_user.id) if found_user
    end
  end
end