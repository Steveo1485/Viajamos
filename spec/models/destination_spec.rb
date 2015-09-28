require 'rails_helper'

RSpec.describe Destination, :type => :model do

  it { should belong_to(:trip) }
  it { should belong_to(:location) }

  before :each do
    @trip = FactoryGirl.create(:trip_with_destinations)
    @first_destination = @trip.destinations.first
  end


  context "#user" do
    it "should return user associate with trip" do
      @user = FactoryGirl.create(:user)
      @destination = FactoryGirl.create(:trip_with_destinations, user: @user).destinations.first
      expect(@destination.user).to eq(@user)
    end
  end

end