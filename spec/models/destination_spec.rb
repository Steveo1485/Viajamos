require 'rails_helper'

RSpec.describe Destination, :type => :model do

  it { should belong_to(:trip) }
  it { should belong_to(:location) }

  context "when trip is booked" do
    before :each do
      @built_trip = FactoryGirl.create(:trip, :with_destination)
      @destination = FactoryGirl.build(:destination, trip: @built_trip)
    end

    it "should validate start_date" do
      expect(@destination).to be_valid
      @destination.start_date = nil
      expect(@destination).to_not be_valid
    end

    it "should validate end_date" do
      expect(@destination).to be_valid
    end
  end

  context "when trip is not booked" do
    before :each do
      @trip = FactoryGirl.create(:trip, :with_destination, certainty: "likely")
      @destination = FactoryGirl.build(:destination, trip: @trip)
    end

    it "should not validate start_date" do
      expect(@destination).to be_valid
      @destination.start_date = nil
      expect(@destination).to be_valid
    end

    it "should not validate end_date" do
      expect(@destination).to be_valid
      @destination.end_date = nil
      expect(@destination).to be_valid
    end
  end

end
