# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170331023358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "waypoints", force: :cascade do |t|
    t.datetime  "sent_at"
    t.string    "vehicle_identifier"
    t.geography "lonlat",             limit: {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime  "created_at",                                                                  null: false
    t.datetime  "updated_at",                                                                  null: false
    t.index ["lonlat"], name: "index_waypoints_on_lonlat", using: :gist
    t.index ["vehicle_identifier"], name: "index_waypoints_on_vehicle_identifier", using: :btree
  end

end
