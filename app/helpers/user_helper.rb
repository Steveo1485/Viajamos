module UserHelper

  def user_home_location_name(user)
    user.home_location.try(:name) || "No home location set"
  end
end
