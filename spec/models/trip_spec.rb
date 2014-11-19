require 'rails_helper'

RSpec.describe Trip, :type => :model do

  it { should belong_to(:location) }
  it { should validate_numericality_of(:location_id) }
  it { should validate_numericality_of(:user_id) }

  context "if certainty is booked" do
    before :each do
      allow(subject).to receive(:certainty).and_return('booked')
    end
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

end
