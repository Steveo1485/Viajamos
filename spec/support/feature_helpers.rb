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
  click_button('Sign In')
end

def fill_in_trip_form(location)
  location ||= FactoryGirl.create(:location)
  start_date = (Date.today + 1.year)
  end_date = (start_date + 5.days)
  find(:xpath, "//input[@id='trip_start_date']").set(start_date.strftime('%m-%d-%Y'))
  find(:xpath, "//input[@id='trip_end_date']").set(end_date.strftime('%m-%d-%Y'))
  find("#trip_destinations_attributes_0_location_id").set(location.id)
  choose("trip_time_period_future")
  choose("trip_certainty_booked")
  select("Leisure", from: "trip_purpose")
end