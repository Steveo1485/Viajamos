require 'rails_helper'

describe "Adding a trip" do
  before :each do
    @location = FactoryGirl.create(:location)
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  it "should display new trip when successful" do
    click_button('Add a trip')
    fill_in_trip_form(@location)
    click_button("Save Trip")
    expect(page).to have_content('Successfully added trip!')
    expect(page).to have_content(@location.city)
  end

end
