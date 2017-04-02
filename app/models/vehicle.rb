class Vehicle < ApplicationRecord

	validates :identifier, presence: true

	has_many :waypoints

	def self.random_vehicle_identifier
		"#{(0...2).map { (65 + rand(26)).chr }.join}-#{rand.to_s[2..5]}"
	end
end
