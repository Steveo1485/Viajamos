require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #show" do
    before :each do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    xit "should render the show template" do
      get :show, id: @user.id
      expect(response).to render_template(:show)
    end
  end

end