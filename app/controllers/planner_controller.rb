class PlannerController < ApplicationController
  skip_after_action :verify_policy_scoped, only: [:index]

  def index
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
    ##### TEMP FACEBOOK CHECK
    if current_user.oauth_token
      graph = Koala::Facebook::API.new(current_user.oauth_token)
      @temp_fb_check = graph.get_connections("me", "friends")
      @temp_fb_check2 = graph.get_connections("me", "friends", api_version: "v2.0")
    end
  end

end