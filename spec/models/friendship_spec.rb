require 'rails_helper'

RSpec.describe Friendship, :type => :model do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:friend_id) }
  it { should ensure_inclusion_of(:type).in_array(["Friend", "TravelBuddy"]) }

end
