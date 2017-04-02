class RemoveVehicleIdentifierToWaypoint < ActiveRecord::Migration[5.0]
  def change
  	remove_column :waypoints, :vehicle_identifier
  end
end
