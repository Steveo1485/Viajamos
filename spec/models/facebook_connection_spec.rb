require 'rails_helper'

RSpec.describe FacebookConnection, :type => :model do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_numericality_of(:friend_user_id) }


  context "#reverse_connection" do
    it "should create a reverse FacebookConnection" do
      connection = FactoryGirl.create(:facebook_connection)
      reverse_connection = FactoryGirl.create(:facebook_connection,
                                              user_id: connection.friend_user_id,
                                              friend_user_id: connection.user_id )
      expect(connection.reverse_connection).to eq(reverse_connection)
      expect(reverse_connection.reverse_connection).to eq(connection)
    end
  end

end
