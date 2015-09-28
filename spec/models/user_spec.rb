require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:facebook_connections) }
  it { should have_many(:favorite_locations) }
  it { should have_many(:friendships) }
  it { should have_many(:trips) }
  it { should belong_to(:home_location) }

  before :each do
    @user = FactoryGirl.create(:user)
    @friend_user = FactoryGirl.create(:user)
  end

  context "#name" do
    it "should return user's first and last name if available" do
      expect(@user.name).to eq("#{@user.first_name} #{@user.last_name}")
    end

    it "should return user's email address if no first and last name is saved" do
      @user.update(first_name: nil, last_name: nil)
      expect(@user.name).to eq(@user.email)
    end
  end

  context "#outstanding_friend_requests" do
    it "should return unconfirmed friendships" do
      @request = create_unconfirmed_friendship(@user, @friend_user)
      expect(@user.outstanding_friend_requests.pluck(:id)).to eq([@request.id])
    end
  end

  context "#friend_requests" do
    it "should return unconfirmed friendships from other users" do
      @request = create_unconfirmed_friendship(@friend_user, @user)
      expect(@user.friend_requests.pluck(:id)).to eq([@request.id])
    end
  end

  context "#friends" do
    it "should return friend user objects for user" do
      create_confirmed_friendship(@user, @friend_user)
      create_unconfirmed_friendship(@user, FactoryGirl.create(:user))
      expect(@user.friends).to eq([@friend_user])
    end
  end

  context "#friends_with?" do
    it "should return true if user is friends with passed user" do
      create_confirmed_friendship(@user, @friend_user)
      expect(@user.friends_with?(@friend_user)).to eq(true)
    end

    it "should return false if user is not friends with passed user" do
      expect(@user.friends_with?(@friend_user)).to eq(false)
    end

    it "should return true if user is travel buddy with passed user" do
      create_confirmed_friendship(@user, @friend_user)
      expect(@user.friends_with?(@friend_user)).to eq(true)
    end
  end

  context '#oauth?' do
    it 'should return true if both provider and uid present' do
      oauth_user = FactoryGirl.create(:user, provider: 'twitter', uid: 1234)
      expect(oauth_user.oauth?).to eq(true)
    end

    it 'should return false if either/both provider and uid missing' do
      expect(@user.oauth?).to eq(false)
    end
  end

  context '#past_trips' do
    it 'should return user trips with time_period of: past' do
      past_trip = FactoryGirl.create(:trip, user: @user, time_period: 'past')
      FactoryGirl.create(:trip, user: @user)
      expect(@user.past_trips).to eq([past_trip])
    end
  end

  context '#city_count' do
    it 'should return the number of cities a user have been to' do
      trip = FactoryGirl.create(:trip_with_destinations, user: @user, time_period: 'past')
      expect(@user.city_count).to eq(trip.destinations.count)
    end
  end

  context '#country_count' do
    it 'should return the number of countries a user have been to' do
      trip = FactoryGirl.create(:trip_with_destinations, user: @user, time_period: 'past')
      expect(@user.country_count).to eq(trip.destinations.count)
    end
  end

  context '#world_domination' do
    it "should return user's visited countries divided by total countries" do
      trip = FactoryGirl.create(:trip_with_destinations, user: @user, time_period: 'past')
      world_domination = trip.destinations.count / Location::TOTAL_COUNTRIES
      expect(@user.world_domination).to eq(world_domination)
    end
  end

  context '#facebook_friends' do
    it 'should return confirmed facebook friends for user' do
      facebook_friend = FactoryGirl.create(:facebook_connection, user: @user).friend_user
      FactoryGirl.create(:facebook_connection, user: @user, ignore: true)
      expect(@user.facebook_friends).to eq([facebook_friend])
    end
  end

  context 'home_name' do
    it 'should return user home location name when set' do
      home_location = FactoryGirl.create(:location)
      @user.update(home_location_id: home_location.id)
      expect(@user.home_name).to eq(home_location.name)
    end

    it "it should return 'no home location set' when no home location set" do
      expect(@user.home_name).to eq('No home location set')
    end
  end
end
