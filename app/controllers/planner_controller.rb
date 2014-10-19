class PlannerController < ApplicationController

  def index
    redirect_to root_path and return unless current_user
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
  end

end