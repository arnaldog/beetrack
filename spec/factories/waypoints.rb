FactoryGirl.define do


  factory :waypoint do
    sent_at "2017-03-31 02:33:59"
    vehicle_identifier "my identifier"
    lonlat Waypoint::GEO_FACTORY.point(-1234, 2343)
  end
end
