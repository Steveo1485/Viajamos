class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      if @user.oauth_token.blank? or @user.oauth_token_expires_at <= (Time.now - 1.week)
        @user.oauth_token = request.env["omniauth.auth"].credentials.token
        @user.oauth_token_expires_at = request.env["omniauth.auth"].credentials.expires_at
        @user.save(validate: false)
      end
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end