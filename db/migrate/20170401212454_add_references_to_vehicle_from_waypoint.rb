class AddReferencesToVehicleFromWaypoint < ActiveRecord::Migration[5.0]
  def change
  	add_reference :waypoints, :vehicle
  end
end
