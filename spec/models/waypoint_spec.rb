require 'rails_helper'

describe Waypoint, type: :model do

  # This three components are necessary to identify a waypoint
  it { is_expected.to validate_presence_of(:lonlat) }
  it { is_expected.to validate_presence_of(:sent_at) }


  before(:each) do
    @waypoint = build(:waypoint)
  end

  it "has a valid factory" do
    expect(@waypoint).to be_valid
  end

  # Testing for relations
  it { is_expected.to belong_to(:vehicle) }

  describe 'Belongs to associations' do
    it 'has a vehicle associated' do
      vehicle = create(:vehicle)
      waypoint = create(:waypoint, vehicle_id: vehicle.id)

      vehicle.reload
      expect(vehicle.waypoints.first).to eql(waypoint)
    end
  end
end
