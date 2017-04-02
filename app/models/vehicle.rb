class Vehicle < ApplicationRecord

	validates :identifier, presence: true

	has_many :waypoints
end
