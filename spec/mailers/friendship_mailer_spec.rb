require "rails_helper"

RSpec.describe FriendshipMailer, :type => :mailer do

  before :each do
    Delayed::Worker.delay_jobs = false
    ActionMailer::Base.deliveries.clear
    @friendship = FactoryGirl.create(:friendship)
    @user_to = User.find(@friendship.friend_id)
    @requester = @friendship.user
  end

  describe "friend_request email" do
    before :each do
      @mail = FriendshipMailer.friend_request(@friendship)
    end

    it "should have the right subject" do
      expect(@mail.subject).to eq("[Co:tripping] #{@requester.name} has sent you a friend request on Co:tripping!")
    end

    it "should be addressed to the correct user's email" do
      expect(@mail.to).to eq([@user_to.email])
    end

    it "should be from do-not-reply@cotripping.com" do
      expect(@mail.from).to eq(['do-not-reply@cotripping.com'])
    end

    it "should include the correct message text" do
      expect(@mail.body).to include("#{@requester.name} would like to add you as a friend on Co:tripping.")
    end
  end
end