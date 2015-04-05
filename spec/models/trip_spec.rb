require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_many(:destinations) }
  it { should have_many(:locations) }

  it { should validate_numericality_of(:user_id) }
  it { should accept_nested_attributes_for(:destinations) }

  context '#any_overlaps?' do
    before :each do
      @trip = FactoryGirl.create(:trip, :with_destination)
    end

    it 'should return true if friend trips overlap' do
      create_friend_overlap(@trip)
      expect(@trip.send(:any_overlaps?)).to eq(true)
    end

    it 'should return false if no friend trip overlaps' do
      expect(@trip.send(:any_overlaps?)).to eq(false)
    end
  end

  context 'friend_overlaps' do
    before :each do
      @trip = FactoryGirl.create(:trip, :with_destination)
    end

    it 'should return overlap trips from friends when present' do
      overlap_trip = create_friend_overlap(@trip)
      expect(@trip.friend_overlaps).to eq([overlap_trip])
    end

    it 'should return no trips when no overlaps with friends' do
      overlap_trip = create_friend_overlap(@trip, 10)
      expect(@trip.friend_overlaps).to eq([])
    end
  end
end

def create_friend_overlap(trip, days_ahead = 1)
  friend = FactoryGirl.create(:friendship, user: trip.user, confirmed: true).friend_user
  overlap_trip = FactoryGirl.create(:trip, :with_destination, user: friend)
  destination = overlap_trip.destinations.last
  destination.location_id = trip.locations.first.id
  destination.start_date = trip.start_date + days_ahead.days
  destination.end_date = trip.end_date + days_ahead.days
  destination.save
  return overlap_trip
end