require 'rails_helper'

RSpec.describe Location, :type => :model do
  it { should have_many(:destinations) }
  it { should have_many(:trips) }

  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:country_code) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:latitude) }
end
