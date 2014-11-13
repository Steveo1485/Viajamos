class TripsController < ApplicationController

  def index
    @trips = policy_scope(Trip)
  end

end