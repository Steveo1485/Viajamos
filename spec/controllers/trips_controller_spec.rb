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
      @build_trip = FactoryGirl.build(:trip)
    end

    it "should create Trip with valid attributes" do
      expect{post :create, trip: @build_trip.attributes}.to change(Trip, :count).by(1)
    end

    it "should not create Trip with valid attributes" do
      @build_trip.user_id = nil
      expect{post :create, trip: @build_trip.attributes}.to_not change(Trip, :count)
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
      location_id = @trip.location_id
      patch :update, id: @trip.id, trip: {location_id: nil }
      expect(@trip.reload.location_id).to eq(location_id)
    end
  end

  describe "DELETE #destroy" do
    it "should destroy a trip" do
      expect{ delete :destroy, id: @trip.id }.to change(Trip, :count).by(-1)
    end
  end
end