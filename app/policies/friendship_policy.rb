class FriendshipPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    user.id == record.user_id
  end

  def update?
    user.id == record.friend_id
  end

  def destroy?
    user.id == record.user_id || user.id == record.friend_id
  end

  def facebook_request?
    user.id == record.user_id
  end
end