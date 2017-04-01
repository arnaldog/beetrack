require 'rails_helper'

describe Waypoint, type: :model do

	# This three components are necessary to identify a waypoint
	it { is_expected.to validate_presence_of(:vehicle_identifier) }
	it { is_expected.to validate_presence_of(:lonlat) }
	it { is_expected.to validate_presence_of(:sent_at) }

	it "has a valid factory" do 
		expect(build(:waypoint)).to be_valid
	end

end
