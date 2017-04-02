class Tracking < ApplicationRecord

  belongs_to :vehicle
  belongs_to :waypoint

  delegate :lonlat, to: :waypoint

  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  def self.from_waypoint waypoint
    track = Tracking.find_or_create_by(vehicle: waypoint.vehicle)
    track.waypoint = waypoint
    track.lonlat = waypoint.lonlat
    track.save
  end
end
