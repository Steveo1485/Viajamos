class UsersController < ApplicationController

  def show
    gon.facebook_app_id = ENV['FACEBOOK_APP_ID']
  end

end