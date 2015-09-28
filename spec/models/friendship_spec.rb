require 'rails_helper'

RSpec.describe Friendship, :type => :model do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:friend_id) }
  it { should validate_inclusion_of(:type).in_array(Friendship.types) }

  before :each do
    @friendship = FactoryGirl.create(:friendship, confirmed: true)
  end

  context "#friend_user" do
    it "should return the user associated with the friendship's friend_id" do
      expect(@friendship.friend_user).to eq(User.find(@friendship.friend_id))
    end
  end

  context "#reverse_friendship" do
    it "should return the reverse friendship" do
      reverse_friendship = FactoryGirl.create(:friendship,
                                              user_id: @friendship.friend_id,
                                              friend_id: @friendship.user_id,
                                              confirmed: true)
      expect(@friendship.reverse_friendship.id).to eq(reverse_friendship.id)
    end
  end

end
