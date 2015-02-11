require 'rails_helper'

RSpec.describe FriendshipsController, :type => :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    @friend = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "POST #create" do
    it "should create friendships with valid params" do
      expect{ post :create, friend_email: @friend.email }.to change(Friendship, :count).by(1)
    end

    it "should redirect to planner after successful creation" do
      post :create, friend_email: @friend.email
      expect(response).to redirect_to(planner_path)
    end

    it "should not create friendship if one already exists" do
      Friendship.create(user_id: @user.id, friend_id: @friend.id, type: "Friend")
      expect{ post :create, friend_email: @friend.email }.to_not change(Friendship, :count)
    end

    it "should not create friendship when friend not found" do
      expect{ post :create, friend_email: "wrong@email.com" }.to_not change(Friendship, :count)
    end

    it "should redirect to planner if creation not successful" do
      post :create, friend_email: "wrong@email.com"
      expect(response).to redirect_to(planner_path)
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

  describe "PATCH #update" do
    before :each do
      @friendship = FactoryGirl.create(:friendship, friend_id: @user.id)
    end

    it "should update to an accepted friendship" do
      patch :update, id: @friendship.id, friendship: {confirmed: true}
      expect(@friendship.reload.confirmed).to eq(true)
    end

    it "should create a mirror friendship when accepted" do
      expect{ post :update, id: @friendship.id, friendship: {confirmed: true} }.to change(Friendship, :count).by(1)
    end

    it "should not create a mirror friendship if already accepted" do
      accepted_friendship = FactoryGirl.create(:friendship, confirmed: true)
      expect{ post :update, id: accepted_friendship.id, friendship: {confirmed: true} }.to_not change(Friendship, :count)
    end

    it "should update friendship and reverse friendship to blocked" do
      @friendship.update(confirmed: true)
      reverse_friendship = FactoryGirl.create(:friendship, user_id: @friend.id, friend_id: @user.id, confirmed: true)
      patch :update, id: @friendship.id, friendship: {type: "Blocked"}
      expect(@friendship.reload.type).to eq("Blocked")
    end
  end
end