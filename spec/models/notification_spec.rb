require 'rails_helper'

RSpec.describe Notification, :type => :model do

  it { should belong_to(:user) }
  it { should belong_to(:notifiable) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:notifiable_id) }
  it { should validate_presence_of(:notifiable_type) }

end
