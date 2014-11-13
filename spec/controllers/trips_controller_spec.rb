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
end