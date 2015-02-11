class FacebookConnectionPolicy < ApplicationPolicy
  attr_reader :user, :facebook_connection

  def initialize(user, facebook_connection)
    @user = user
    @facebook_connection = facebook_connection
  end

  def update?
    @user.id == @facebook_connection.user_id
  end
end