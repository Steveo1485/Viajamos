require 'rails_helper'

RSpec.describe FacebookConnection, :type => :model do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_numericality_of(:friend_user_id) }

  before :each do
    @connection = FactoryGirl.create(:facebook_connection)
  end

  context "active scope" do
    before :each do
      @inactive_1 = FactoryGirl.create(:facebook_connection, request_sent: true)
      @inactive_2 = FactoryGirl.create(:facebook_connection, ignore: true)
      @inactive_3 = FactoryGirl.create(:facebook_connection, request_sent: true, ignore: true)
    end

    it "should return facebook connections where request_sent and ignore are false" do
      expect(FacebookConnection.active.pluck(:id)).to eq([@connection.id]) 
    end
  end

  context "#reverse_connection" do
    it "should return the reverse FacebookConnection" do
      reverse_connection = FactoryGirl.create(:facebook_connection,
                                              user_id: @connection.friend_user_id,
                                              friend_user_id: @connection.user_id )
      expect(@connection.reverse_connection).to eq(reverse_connection)
      expect(reverse_connection.reverse_connection).to eq(@connection)
    end
  end

  context "#friend_user" do
    it "should return friend user of connection" do
      friend_user = User.find(@connection.friend_user_id)
      expect(@connection.friend_user).to eq(friend_user)
    end
  end

  context "#ignored?" do
    it "should return true when ignore is true" do
      expect(@connection.ignored?).to eq(false)
    end

    it "should return false when ignore is false" do
      @connection.update(ignore: true)
      expect(@connection.ignored?).to eq(true)
    end
  end

end