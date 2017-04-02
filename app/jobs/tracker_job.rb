class TrackerJob < ApplicationJob
  def perform(*args)
    latitude, longitude, sent_at, vehicle = args
    Waypoint.create(lonlat: point(longitude, latitude), sent_at: sent_at, vehicle: vehicle)
  end

  def point longitude, latitude
    @point  ||= Waypoint::GEO_FACTORY.point(longitude, latitude)
  end
end
