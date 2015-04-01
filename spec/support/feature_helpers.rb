def sign_in(user)
  navigate_to_sign_in
  fill_in_and_submit_sign_in(user)
end

def navigate_to_sign_in
  visit root_path
  within('.navbar') do
    click_link('Sign In')
  end
end

def fill_in_and_submit_sign_in(user)
  fill_in('user[email]', with: user.email)
  fill_in('user[password]', with: user.password)
  click_button('Log in')
end

def fill_in_trip_form(location)
  location ||= FactoryGirl.create(:location)
  start_date = Date.today + 1.year
  return_date = start_date + 5.days
  find("#trip_destinations_attributes_0_location_id").set(location.id)
  select(start_date.day, from: "trip_destinations_attributes_0_start_date_3i")
  select(start_date.strftime("%B"), from: "trip_destinations_attributes_0_start_date_2i")
  select(start_date.year, from: "trip_destinations_attributes_0_start_date_1i")
  select(return_date.day + 1, from: "trip_departure_date_3i")
  select(return_date.strftime("%B"), from: "trip_departure_date_2i")
  select(return_date.year, from: "trip_departure_date_1i")
  choose("trip_time_period_future")
  choose("trip_certainty_booked")
  select("Leisure", from: "trip_purpose")
end