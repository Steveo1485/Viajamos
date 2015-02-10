require 'rails_helper'

RSpec.describe FacebookConnection, :type => :model do

  it { should belong_to(:user) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_numericality_of(:friend_user_id) }

end
