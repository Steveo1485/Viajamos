require 'rails_helper'

RSpec.describe Destination, :type => :model do

  it { should belong_to(:trip) }
  it { should belong_to(:location) }
  it { should validate_presence_of(:day_offset) }

  before :each do
    @trip = FactoryGirl.create(:trip_with_destinations)
    @first_destination = @trip.destinations.first
  end

  context "::day_order" do
    it "should order destinations by day_offset asc" do
      destination1 = FactoryGirl.create(:destination, day_offset: 2)
      destination2 = FactoryGirl.create(:destination, day_offset: 1)
      expect(Destination.day_order.pluck(:id)).to eq([@first_destination.id, destination2.id, destination1.id])
    end
  end

  context "#user" do
    it "should return user associate with trip" do
      @user = FactoryGirl.create(:user)
      @destination = FactoryGirl.create(:trip_with_destinations, user: @user).destinations.first
      expect(@destination.user).to eq(@user)
    end
  end

  context "#start_date" do
    it "should return the trip start date if day_offset is 0" do
      expect(@first_destination.start_date).to eq(@trip.start_date)
    end

    it "should return the trip start date plus the day offset" do
      destination = FactoryGirl.create(:destination, trip: @trip, day_offset: 3)
      @trip.destinations << destination
      expect(destination.start_date).to eq(@trip.start_date + 3.days)
    end
  end

  context "#end_date" do
    it "should return the trip end_date if destination is last of trip" do
      expect(@first_destination.end_date).to eq(@trip.end_date)
    end

    it "should return the start_date of the next trip destination" do
      destination = FactoryGirl.create(:destination, trip: @trip, day_offset: 3)
      @trip.destinations << destination
      expect(@first_destination.end_date).to eq(destination.start_date)
    end
  end

  # context "#find_overlaps" do
  #   before :each do
  #     @destination = FactoryGirl.create(:trip, :with_destination).destinations.first
  #   end

  #   it "should return overlaps with friends when found" do
  #     @overlap_destination = create_friend_overlap(@destination.trip).destinations.first
  #     expect(@destination.friend_overlaps).to eq([@overlap_destination])
  #   end

  #   it "should return empty collection when no overlaps with friends found" do
  #     @friend_destination = create_friend_overlap(@destination.trip, 14).destinations.first
  #     expect(@destination.friend_overlaps).to eq([])
  #   end
  # end

  # context "#any_overlaps?" do
  #   before :each do
  #     @destination = FactoryGirl.create(:trip, :with_destination).destinations.first
  #   end

  #   it "should return true if friend overlaps exists" do
  #     @overlap_destination = create_friend_overlap(@destination.trip).destinations.first
  #     expect(@destination.any_overlaps?).to eq(true)
  #   end

  #   it "should return false if no friend overlaps exists" do
  #     @friend_destination = create_friend_overlap(@destination.trip, 14).destinations.first
  #     expect(@destination.any_overlaps?).to eq(false)
  #   end
  # end
end