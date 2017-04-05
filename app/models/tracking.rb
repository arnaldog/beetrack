class Tracking < ApplicationRecord

  belongs_to :vehicle
  belongs_to :waypoint

  delegate :lonlat, to: :waypoint

  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  def self.from_waypoint waypoint
    track = Tracking.find_or_create_by(vehicle: waypoint.vehicle)
    track.waypoint = waypoint
    track.lonlat = waypoint.lonlat
    track.vehicle_identifier = waypoint.vehicle.identifier
    track.save
  end

  def self.bbox
    bbox_hash_from Tracking.pluck('st_extent(lonlat::geometry)').first
  end


  private

  def self.bbox_hash_from bbox_wkt

    bbox_wkt ||= 'BOX(0 0, 0 0)'
    min, max = bbox_wkt.sub('BOX', '').sub('(', '').sub(')', '').split(',') unless bbox_wkt.blank?

    min_lon, min_lat = min.split
    max_lon, max_lat = max.split

    {
        min_latitude: min_lat.to_f,
        max_latitude: max_lat.to_f,
        min_longitude: min_lon.to_f,
        max_longitude: max_lon.to_f
    }
  end
end
