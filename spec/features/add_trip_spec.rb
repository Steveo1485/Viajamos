require 'rails_helper'

describe "Adding a trip" do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  xit "should create new trip when valid information entered" do
  end

end
