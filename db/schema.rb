# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161119162147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "car_model"
    t.string   "car_number"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "pickup_address"
    t.string   "dropoff_address"
    t.float    "pickup_lat"
    t.float    "pickup_lon"
    t.float    "dropoff_lat"
    t.float    "dropoff_lon"
    t.string   "client_name"
    t.string   "phone"
    t.float    "distance"
    t.decimal  "price",           precision: 5, scale: 2
    t.boolean  "completed",                               default: false
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "driver_id"
  end

  add_foreign_key "orders", "drivers"
end
