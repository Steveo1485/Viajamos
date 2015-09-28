require 'rails_helper'

RSpec.describe Destination, :type => :model do

  it { should belong_to(:location) }
  it { should belong_to(:trip) }

  before :each do
    @trip = FactoryGirl.create(:trip_with_destinations)
    @destination = @trip.destinations.first
    @user = @trip.user
  end


  context "#user" do
    it "should return user associate with trip" do
      expect(@destination.user).to eq(@user)
    end
  end

end