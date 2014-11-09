require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST #find_friends" do
    it "should redirect if sent current user's email address" do
      post :find_friends, requested_friend_email: @user.email
      expect(response).to redirect_to(planner_path)
    end

    it "should redirect if requested user not found" do
      post :find_friends, requested_friend_email: "unknown@email.com"
      expect(response).to redirect_to(planner_path)
    end

    it "should render find_friends when requested user found" do
      post :find_friends, requested_friend_email: @friend.email
      expect(response).to render_template(:find_friends)
      expect(assigns(:requested_user).id).to eq(@friend.id)
    end
  end

  describe "POST #create" do
    it "should create friendships with valid params" do
      expect{ post :create, friendship: {type: "Friend", friend_id: @friend.id} }.to change(Friendship, :count).by(1)
    end

    it "should redirect to planner after successful creation" do
      post :create, friendship: {type: "Friend", friend_id: @friend.id}
      expect(response).to redirect_to(planner_path)
    end

    it "should not create friendship if one already exists" do
      Friendship.create(user_id: @user.id, friend_id: @friend.id, type: "Friend")
      expect{ post :create, friendship: {type: "Friend", friend_id: @friend.id} }.to_not change(Friendship, :count)
    end

    it "should not create friendship with invalid params" do
      expect{ post :create, friendship: {type: "", friend_id: @friend.id} }.to_not change(Friendship, :count)
    end

    it "should render find_friends template if creation not successful" do
      post :create, friendship: {type: "", friend_id: @friend.id}
      expect(response).to render_template(:find_friends)
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @friendship = FactoryGirl.create(:friendship, user: @user)
    end

    it "should destroy a friendship when found" do
      expect{ delete :destroy, id: @friendship.id }.to change(Friendship, :count).by(-1)
    end
  end

  describe "POST #accept" do
    before :each do
      @friendship = FactoryGirl.create(:friendship, friend_id: @user.id)
    end

    it "should accept a friendship when found" do
      post :accept, id: @friendship.id
      expect(@friendship.reload.confirmed).to eq(true)
    end

    it "should create a mirror friendship when accepted" do
      expect{ post :accept, id: @friendship.id }.to change(Friendship, :count).by(1)
    end

    it "should not create a mirror friendship if already accepted" do
      accepted_friendship = FactoryGirl.create(:friendship, confirmed: true)
      expect{ post :accept, id: accepted_friendship.id }.to_not change(Friendship, :count)
    end
  end

  describe "PATCH #block" do
    before :each do
      @friendship = FactoryGirl.create(:friendship, confirmed: true, user: @user, friend_id: @friend.id)
      @reverse_friendship = FactoryGirl.create(:friendship, user_id: @friend.id, friend_id: @user.id, confirmed: true)
    end

    it "should update Friendship type to blocked" do
      patch :block, id: @friendship.id
      expect(@friendship.reload.type).to eq("Blocked")
      expect(@reverse_friendship.reload.type).to eq("Blocked")
    end
  end

  describe "PATCH #facebook_request" do
    before :each do
      @fb_connection = FactoryGirl.create(:friendship, type: "FacebookConnection", user: @user, friend_id: @friend.id)
      @fb_connection_reverse = FactoryGirl.create(:friendship, 
                                                  type: "FacebookConnection", 
                                                  user_id: @friend.id,
                                                  friend_id: @user.id)
    end

    it "should update type of Friendship to specified type" do
      patch :facebook_request, id: @fb_connection.id, friendship: {type: "Friend"}
      expect(@fb_connection.reload.type).to eq("Friend")
    end


    it "should destroy reverse FacebookConnection" do
      expect{ patch :facebook_request, id: @fb_connection.id, friendship: {type: "Friend"} }.to change(Friendship, :count).by(-1)
    end
  end
end