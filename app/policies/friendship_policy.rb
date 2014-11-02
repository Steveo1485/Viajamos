class FriendshipPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def find_friends?
    user
  end

  def create?
    user.id == record.user_id
  end

  def accept?
    user.id == record.friend_id
  end

  def destroy?
    user.id == record.user_id || user.id == record.friend_id
  end

  def block?
    user.id == record.user_id
  end

  def facebook_request?
    user.id == record.user_id
  end
end