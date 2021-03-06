require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:friendships) }
  it { should have_many(:trips) }
  it { should belong_to(:home_location) }

  before :each do
    @user = FactoryGirl.create(:user)
    @friend_user = FactoryGirl.create(:user)
  end

  context "#name" do
    it "should return user's first and last name if available" do
      expect(@user.name).to eq("#{@user.first_name} #{@user.last_name}")
    end

    it "should return user's email address if no first and last name is saved" do
      @user.update(first_name: nil, last_name: nil)
      expect(@user.name).to eq(@user.email)
    end
  end

  context "#outstanding_friend_requests" do
    it "should return unconfirmed friendships" do
      @request = FactoryGirl.create(:friendship, user: @user, friend_id: @friend_user.id)
      expect(@user.outstanding_friend_requests.pluck(:id)).to eq([@request.id])
    end
  end

  context "#friend_requests" do
    it "should return unconfirmed friendships from other users" do
      @request = FactoryGirl.create(:friendship, user: @friend_user, friend_id: @user.id)
      expect(@user.friend_requests.pluck(:id)).to eq([@request.id])
    end
  end

  context "#friends" do
    it "should return friend user objects for user" do
      @confirmed_friend = FactoryGirl.create(:friendship, type: "Friend", user: @user, friend_id: @friend_user.id, confirmed: true)
      @unconfirmed_friend = FactoryGirl.create(:friendship, type: "Friend", user: @user, friend_id: FactoryGirl.create(:user).id)
      expect(@user.friends).to eq([@friend_user])
    end
  end

  context "#friends_with?" do
    it "should return true if user is friends with passed user" do
      FactoryGirl.create(:friendship, type: "Friend", user: @user, friend_id: @friend_user.id, confirmed: true)
      expect(@user.friends_with?(@friend_user)).to eq(true)
    end

    it "should return false if user is not friends with passed user" do
      expect(@user.friends_with?(@friend_user)).to eq(false)  
    end

    it "should return true if user is travel buddy with passed user" do
      FactoryGirl.create(:friendship, user: @user, friend_id: @friend_user.id, confirmed: true)
      expect(@user.friends_with?(@friend_user)).to eq(true)
    end
  end
end
