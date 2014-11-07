class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
  
  def show?
    user == record
  end

  def edit?
    user == record
  end

  def update?
    user == record
  end

end

