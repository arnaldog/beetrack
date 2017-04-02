class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :identifier, limit: 7
      t.timestamps
      t.index :identifier, unique: true
    end
  end
end
