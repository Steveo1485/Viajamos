require 'rails_helper'

RSpec.describe TripsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @trip = FactoryGirl.create(:trip, user: @user)
    @other_trip = FactoryGirl.create(:trip)
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
      @valid_params = FactoryGirl.attributes_for(:trip, destinations_attributes: [FactoryGirl.build(:destination).attributes] )
    end

    it "should create a Trip with valid attributes" do
      expect{post :create, trip: @valid_params}.to change(Trip, :count).by(1)
    end

    it "should create a Destination for the created Trip with valid attributes" do
      expect{post :create, trip: @valid_params}.to change(Destination, :count).by(1)
      expect(Destination.last.trip).to eq(Trip.last)
    end

    it "should not create Trip with invalid attributes" do
      @valid_params.delete(:certainty)
      expect{post :create, trip: @valid_params}.to_not change(Trip, :count)
    end

    it "should not create a Trip or Destination with invalid destination attributes" do
      destination_attributes = FactoryGirl.build(:destination).attributes
      destination_attributes.delete("location_id")
      @invalid_params = FactoryGirl.attributes_for(:trip, destinations_attributes: [destination_attributes] )
      expect{post :create, trip: @invalid_params}.to_not change(Trip, :count)
      expect{post :create, trip: @invalid_params}.to_not change(Destination, :count)
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