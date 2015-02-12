class FriendshipMailer < ActionMailer::Base
  default from: "Co:tripping <do-not-reply@cotripping.com>"

  def friend_request(friendship)
    @user = User.find(friendship.friend_id)
    @requesting_user = friendship.user
    if @user.email
      mail to: @user.email, subject: "Co:tripping Friend Request"
    end
  end

end