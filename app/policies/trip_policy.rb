class TripPolicy < ApplicationPolicy
  attr_reader :user, :trip

  def initialize(user, trip)
    @user = user
    @trip = trip
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(user_id: user.id)
    end
  end
end