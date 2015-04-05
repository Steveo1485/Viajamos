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

  context "#find_overlaps" do
    before :each do
      @destination = FactoryGirl.create(:trip, :with_destination).destinations.first
    end

    it "should return overlaps with friends when found" do
      @overlap_destination = create_friend_overlap(@destination.trip).destinations.first
      expect(@destination.friend_overlaps).to eq([@overlap_destination])
    end

    it "should return empty collection when no overlaps with friends found" do
      @friend_destination = create_friend_overlap(@destination.trip, 14).destinations.first
      expect(@destination.friend_overlaps).to eq([])
    end
  end

  context "#any_overlaps?" do
    before :each do
      @destination = FactoryGirl.create(:trip, :with_destination).destinations.first
    end

    it "should return true if friend overlaps exists" do
      @overlap_destination = create_friend_overlap(@destination.trip).destinations.first
      expect(@destination.any_overlaps?).to eq(true)
    end

    it "should return false if no friend overlaps exists" do
      @friend_destination = create_friend_overlap(@destination.trip, 14).destinations.first
      expect(@destination.any_overlaps?).to eq(false)
    end
  end
end