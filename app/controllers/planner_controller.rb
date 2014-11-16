class PlannerController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
    @trip = Trip.new
  end

end