class TripPolicy < ApplicationPolicy
  attr_reader :user, :trip

  def initialize(user, trip)
    @user = user
    @trip = trip
  end

  def create?
    @user
  end

  def update?
    @user.id = @trip.user_id
  end

  def destroy?
    @user.id == @trip.user_id
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(user_id: user.id)
    end
  end
end