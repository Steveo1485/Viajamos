require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET #show" do
    it "should render the show template" do
      get :show, id: @user.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #edit" do
    it "should render the edit template" do
      get :edit, id: @user.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "should update the user when provided correct current password" do
      patch :update, id: @user.id, user: {current_password: @user.password, first_name: "Hank"}
      expect(@user.reload.first_name).to eq("Hank")
    end

    it "should not update the user if provided password is incorrect" do
      patch :update, id: @user.id, user: {current_password: "incorrect-password", first_name: "Hank"}
      expect(@user.reload.first_name).to_not eq("Hank")
    end

    it "should not update the user if validations fail" do
      patch :update, id: @user.id, user: {current_password: @user.password, email: ""}
      expect(@user.reload.email).to_not be_blank
      expect(response).to render_template(:edit)
    end
  end

end