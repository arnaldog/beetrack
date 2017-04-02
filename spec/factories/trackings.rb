FactoryGirl.define do
  factory :tracking do
    vehicle nil
    waypoint nil
    lonlat {
    	address = Faker::Address
    	Waypoint::GEO_FACTORY.point(address.longitude, address.latitude)
    }
    
  end
end
