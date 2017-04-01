class Waypoint < ApplicationRecord
	validates :vehicle_identifier, presence: true
	validates :lonlat, presence: true
	validates :sent_at, presence: true

	GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)
end
