class PlannerController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
    ##### TEMP FACEBOOK CHECK
    graph = Koala::Facebook::API.new(current_user.oauth_token)
    @temp_fb_check = graph.get_connections("me", "friends")
  end

end