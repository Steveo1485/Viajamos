require 'rails_helper'

RSpec.describe FacebookConnectionsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @facebook_connection = FactoryGirl.create(:facebook_connection, user: @user)
    sign_in @user
  end

  describe "PATCH #update" do
    it "should update FacebookConnection with valid params" do
      patch :update, id: @facebook_connection.id, facebook_connection: {ignore: true}
      expect(@facebook_connection.reload.ignore).to eq(true)
    end

    it 'should not update FacebookConnection with invalid params' do
      patch :update, id: @facebook_connection.id, facebook_connection: {friend_user_id: nil}
      expect(response).to redirect_to(root_path)
    end
  end
end