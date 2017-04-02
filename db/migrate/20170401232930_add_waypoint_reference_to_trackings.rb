class AddWaypointReferenceToTrackings < ActiveRecord::Migration[5.0]
  def change
    add_reference :trackings, :waypoint
  end
end
