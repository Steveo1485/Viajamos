require 'rails_helper'

RSpec.describe User, :type => :model do

  it { should have_many(:friendships) }

  before :each do
    @user = FactoryGirl.create(:user)
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

end
