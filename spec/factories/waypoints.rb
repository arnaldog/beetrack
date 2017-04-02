FactoryGirl.define do


  factory :waypoint do
    sent_at "2017-03-31 02:33:59"
    lonlat {
    	address = Faker::Address
    	Waypoint::GEO_FACTORY.point(address.longitude, address.latitude)
    }
  end
end
