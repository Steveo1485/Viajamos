require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_many(:destinations) }
  it { should have_many(:locations) }

  it { should validate_numericality_of(:user_id) }
  it { should accept_nested_attributes_for(:destinations) }

end
