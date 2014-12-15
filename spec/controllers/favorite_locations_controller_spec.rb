require 'rails_helper'

RSpec.describe FavoriteLocationsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @location = FactoryGirl.create(:location)
    sign_in @user
  end

  describe "GET #new" do
    it "should render the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    it "should create a favorite location with valid attributes" do
      expect{ post :create, favorite_location: {location_id: @location.id} }.to change(FavoriteLocation, :count).by(1)
    end

    it "should not create a favorite location with invalid attributes" do
      FactoryGirl.create(:favorite_location, user: @user, location: @location)
      expect{ post :create, favorite_location: {location_id: @location.id} }.to_not change(FavoriteLocation, :count)
      expect{ post :create, favorite_location: {location_id: ""} }.to_not change(FavoriteLocation, :count)
    end
  end

  describe "DELETE #destroy" do
    it "should destroy a favorite location if it belongs to the current user" do
      favorite_location = FactoryGirl.create(:favorite_location, user: @user, location: @location)
      expect{ delete :destroy, id: favorite_location.id}.to change(FavoriteLocation, :count).by(-1)
    end

    it "should not destroy a favorite location if it doesn't belong to the current user" do
      favorite_location = FactoryGirl.create(:favorite_location, location: @location)
      expect{ delete :destroy, id: favorite_location.id}.to_not change(FavoriteLocation, :count)
    end
  end

end