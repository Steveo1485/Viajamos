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

  context "with friend overlap" do
    before :each do
      Delayed::Worker.delay_jobs = false
      @friendship = FactoryGirl.create(:friendship, user: @user, confirmed: true)
      @trip = FactoryGirl.create(:trip_with_destinations, user: @friendship.friend_user)
      @location = @trip.locations.first
    end

    xit "should notify the user of the overlap" do
      click_button('Add a trip')
      fill_in_trip_form(@location)
      click_button("Save Trip")
      expect(page).to have_content('Trip overlap with friend!')
    end
  end
end
