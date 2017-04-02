class Waypoint < ApplicationRecord

	# Validations
	validates :lonlat, presence: true
	validates :sent_at, presence: true

	# Relations
	belongs_to :vehicle

	# Callbacks
	after_create :track_position

	GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

	private 

	def track_position
		## Send this to a queue
		Tracking.from_waypoint self
	end
end
