class PlannerController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    @trips = current_user.trips
    @trip = Trip.new
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
  end

end