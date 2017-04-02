require 'rails_helper'

describe Vehicle, type: :model do

	it { is_expected.to validate_presence_of(:identifier) }
 	it { is_expected.to have_many(:waypoints) }

 	it 'has a valid factory' do 
		expect(build(:vehicle)).to be_valid
 	end

 	it 'has to create a vehicle with an identifier' do 
 		vehicle = Vehicle.find_or_create_by(identifier: 'GG-TX17')
 		expect(vehicle).to be_valid
 	end
end
