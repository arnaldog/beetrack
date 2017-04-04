require 'rails_helper'
require 'sidekiq/testing'

describe Tracking, type: :model do

  it 'should record onley the last position by vehicle' do

    Sidekiq::Testing.inline! do
      vehicle = create(:vehicle, identifier: 'GG-TX19')
      waypoint1 = create(:waypoint, vehicle: vehicle)
      waypoint2 = create(:waypoint, vehicle: vehicle)
      waypoint3 = create(:waypoint, vehicle: vehicle)
      waypoint4 = create(:waypoint, vehicle: vehicle)


      expect(Tracking.count).to eql(1)
      expect(Waypoint.count).to eql(4)


      tracking = Tracking.find_by(vehicle: vehicle)
      expect(tracking.lonlat).to eql(waypoint4.lonlat)
    end

  end


  describe 'bounding box' do

    context 'table is empty' do
      it 'empty bounding box ' do
        result = Tracking.bbox
        expect(result[:min_latitude]).to eql(0.0)
        expect(result[:min_longitude]).to eql(0.0)
        expect(result[:max_latitude]).to eql(0.0)
        expect(result[:max_longitude]).to eql(0.0)
      end
    end

    context 'there are points' do
      before(:each) do

        Sidekiq::Testing.inline! do
          vehicle = create(:vehicle, identifier: 'HA-3244')
          vehicle2= create(:vehicle, identifier: 'AD-1234')

          min_point = Waypoint::GEO_FACTORY.point(-77.33, -33.33)
          max_point = Waypoint::GEO_FACTORY.point(-72.22, -32.22)

          Waypoint.create(vehicle: vehicle, sent_at: DateTime.now, lonlat: min_point)
          Waypoint.create(vehicle: vehicle2, sent_at: DateTime.now, lonlat: max_point)
        end

      end

      it 'should return a bbox' do
        bbox = Tracking.bbox
        expect(bbox[:min_latitude]).to eql(-33.33)
        expect(bbox[:min_longitude]).to eql(-77.33)
        expect(bbox[:max_latitude]).to eql(-32.22)
        expect(bbox[:max_longitude]).to eql(-72.22)
      end

    end

  end
end
