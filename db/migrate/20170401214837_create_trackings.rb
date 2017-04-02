class CreateTrackings < ActiveRecord::Migration[5.0]
  def change
    create_table :trackings do |t|
      t.references :vehicle, index: true, foreign_key: true
      t.st_point :lonlat, geographic: true, srid: 4326
      t.timestamps
    end
  end
end
