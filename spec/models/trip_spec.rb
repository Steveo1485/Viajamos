require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_many(:destinations) }
  it { should have_many(:locations) }

  it { should validate_numericality_of(:user_id) }

  context "if certainty is booked" do
    before :each do
      allow(subject).to receive(:certainty).and_return('booked')
    end
  end

end
