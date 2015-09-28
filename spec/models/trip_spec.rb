require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_many(:destinations) }
  it { should have_many(:locations) }

  it { should validate_numericality_of(:user_id) }
  it { should accept_nested_attributes_for(:destinations) }

  it { should validate_inclusion_of(:time_period).in_array(Trip::TIME_PERIODS) }
  it { should validate_inclusion_of(:certainty).in_array(Trip::CERTAINTIES) }
  it { should validate_inclusion_of(:purpose).in_array(Trip::PURPOSES) }

  before :each do
    @trip = FactoryGirl.create(:trip_with_destinations)
    @user = @trip.user
  end

  it 'should not be valid if booked and no end_date' do
    trip = FactoryGirl.create(:trip)
    trip.end_date = nil
    expect(trip).to_not be_valid
  end

  context '#set_dates?' do
    it 'should return true if both start_date and end_date specified' do
      expect(@trip.set_dates?).to eq(true)
    end

    it 'should return false unless both start_date and end_date are specified' do
      expect(FactoryGirl.create(:trip, certainty: 'possible', start_date: nil, end_date: nil).set_dates?).to eq(false)
    end
  end

  context "#date_range" do
    it "should return formatted string of start/end dates" do
      expect(@trip.date_range).to eq("#{(Date.today + 7.days).strftime('%e %b %Y')} - #{(Date.today + 14.days).strftime('%e %b %Y')}")
    end

    it "should return 'not set' string if start/end date not set" do
      expect(FactoryGirl.create(:trip, certainty: 'possible', start_date: nil).date_range).to eq('No date set for trip')
    end
  end

  context '#cities' do
    it 'should return array of location city names' do
      expect(@trip.cities).to eq([@trip.locations.first.city])
    end
  end

  context "#friend_overlaps" do
    before :each do
      @friend = create_friend(@user)
      random_trip = FactoryGirl.create(:trip_with_destinations)
      friend_trip_outside_range = FactoryGirl.create(:trip_with_destinations,
                                                     user: @friend,
                                                     start_date: Date.today + 30.days,
                                                     end_date: Date.today + 40.days)
    end

    it "should return overlap trips with friends" do
      friend_trip = FactoryGirl.create(:trip_with_destinations, user: @friend)
      expect(@trip.friend_overlaps).to eq([friend_trip])
    end

    it "should return empty collection if no overlaps" do
      expect(@trip.friend_overlaps).to be_empty
    end
  end

  context "#any_overlaps?" do
    before :each do
      @friend = create_friend(@user)
    end

    it "should return true if any friend overlaps" do
      FactoryGirl.create(:trip_with_destinations, user: @friend)
      expect(@trip.any_overlaps?).to eq(true)
    end

    it "should return false if no friend overlaps" do
      expect(@trip.any_overlaps?).to eq(false)
    end
  end

  context '#booked?' do
    it 'should return true if certainty is booked' do
      expect(@trip.booked?).to eq(true)
    end

    it 'should return false if certainty is anything other than booked' do
      expect(FactoryGirl.create(:trip, certainty: 'possible').booked?).to eq(false)
    end
  end
end