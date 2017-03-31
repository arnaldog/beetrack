class CreateWaypoints < ActiveRecord::Migration[5.0]
  def change
    create_table :waypoints do |t|
      t.datetime :sent_at
      t.string :vehicle_identifier
      t.st_point :lonlat, geographic: true, srid: 4326

      t.timestamps
    end
    add_index :waypoints, :vehicle_identifier
    add_index :waypoints, :lonlat, using: :gist
  end
end
