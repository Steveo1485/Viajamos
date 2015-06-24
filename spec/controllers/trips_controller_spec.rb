require 'rails_helper'

RSpec.describe TripsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @trip = FactoryGirl.create(:trip_with_destinations, user: @user)
    @other_trip = FactoryGirl.create(:trip_with_destinations)
    sign_in @user
  end

  describe "GET #index" do
    it "should render the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "should assign only the current user's trips" do
      get :index
      expect(assigns[:trips]).to eq([@trip])
    end
  end

  describe "GET #new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before :each do
      @built_trip = FactoryGirl.build(:trip)
      @built_destination = FactoryGirl.build(:destination, trip: @built_trip)
      @trip_params = @built_trip.attributes.merge(departure_date: Faker::Date.forward(7), destinations_attributes: [@built_destination.attributes])
    end

    it "should create a Trip with valid attributes" do
      expect{post :create, trip: @trip_params}.to change(Trip, :count).by(1)
    end

    it "should create a Destination for the created Trip with valid attributes" do
      expect{post :create, trip: @trip_params}.to change(Destination, :count).by(1)
      expect(Destination.last.trip).to eq(Trip.last)
    end

    it "should not create Trip with invalid attributes" do
      @trip_params[:certainty] = nil
      expect{post :create, trip: @trip_params}.to_not change(Trip, :count)
    end

    context "with trip overlap" do
      before :each do
        Delayed::Worker.delay_jobs = false
        @friendship = FactoryGirl.create(:friendship, user: @user, confirmed: true)
        @trip = FactoryGirl.create(:trip_with_destinations, user: @friendship.friend_user)
        destination_attributes = [{location_id: @trip.destinations.first.location_id, day_offset: 2}]
        @trip_params = @trip.attributes.merge(certainty: 'possible', destinations_attributes: destination_attributes)
      end

      it "should create new trip notification" do
        expect{post :create, trip: @trip_params}.to change(Notification, :count).by(2)
      end
    end
  end

  describe "GET #edit" do
    it "should render the edit template" do
      get :edit, id: @trip.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "should update a trip with valid attributes" do
      patch :update, id: @trip.id, trip: {certainty: "likely"}
      expect(@trip.reload.certainty).to eq("likely")
    end

    it "should not update trip with invalid attributes" do
      time_period = @trip.time_period
      patch :update, id: @trip.id, trip: {time_period: nil }
      expect(@trip.reload.time_period).to eq(time_period)
    end
  end

  describe "DELETE #destroy" do
    it "should destroy a trip" do
      expect{ delete :destroy, id: @trip.id }.to change(Trip, :count).by(-1)
    end
  end
end