class AddVehicleIdentifierToTrackings < ActiveRecord::Migration[5.0]
  def change
  	add_column :trackings, :vehicle_identifier, :string
  end
end
