class FavoriteLocationPolicy < ApplicationPolicy
  attr_reader :user, :favorite_location

  def initialize(user, favorite_location)
    @user = user
    @favorite_location = favorite_location
  end

  def create?
    @user.id == @favorite_location.user_id
  end

  def destroy?
    @user.id == @favorite_location.user_id
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope.where(user_id: user.id)
    end
  end
end