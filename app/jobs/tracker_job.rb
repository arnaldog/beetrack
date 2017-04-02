class TrackerJob < ApplicationJob
  def perform(*args)
    latitude, longitude, sent_at, vehicle = args
    Waypoint.create(lonlat: point(latitude, longitude), sent_at: sent_at, vehicle: vehicle)
  end

  def point latitude, longitude
    @point  ||= Waypoint::GEO_FACTORY.point(latitude, longitude)
  end
end
