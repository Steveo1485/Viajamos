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
      expect(@trip.any_overlaps?).to eq(true)
    end

    it 'should return false if no friend trip overlaps' do
      expect(@trip.any_overlaps?).to eq(false)
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