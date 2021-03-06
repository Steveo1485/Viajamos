class FriendshipMailer < ActionMailer::Base
  default from: "Cotripping <do-not-reply@cotripping.com>"

  def friend_request(friendship)
    @user = User.find(friendship.friend_id)
    @requesting_user = friendship.user
    if @user.email
      mail to: @user.email, subject: "[Co:tripping] #{@requesting_user.name} has sent you a friend request on Co:tripping!"
    end
  end

end