require 'rails_helper'

describe Tracking, type: :model do

  it 'should record onley the last position by vehicle' do
  	vehicle = create(:vehicle, identifier: 'GG-TX19')

  	waypoint1 = create(:waypoint, vehicle: vehicle)
    waypoint2 = create(:waypoint, vehicle: vehicle)
    waypoint3 = create(:waypoint, vehicle: vehicle)
    waypoint4 = create(:waypoint, vehicle: vehicle)


    expect(Tracking.count).to eql(1)

    tracking = Tracking.find_by(vehicle: vehicle)
    expect(tracking.lonlat).to eql(waypoint4.lonlat)
  end

end
