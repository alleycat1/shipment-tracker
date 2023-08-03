# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_03_22_185228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "pallet_scans", force: :cascade do |t|
    t.bigint "pallet_id", null: false
    t.string "location"
    t.boolean "sticker_destroyed"
    t.datetime "date"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pallet_id"], name: "index_pallet_scans_on_pallet_id"
  end

  create_table "pallets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shipment_id", null: false
    t.string "content"
    t.string "content_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "qr_code_type", default: 0
    t.boolean "is_complete", default: false
    t.index ["shipment_id"], name: "index_pallets_on_shipment_id"
    t.index ["user_id"], name: "index_pallets_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "scans", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.string "location"
    t.boolean "sticker_destroyed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "date"
    t.float "latitude"
    t.float "longitude"
    t.index ["shipment_id"], name: "index_scans_on_shipment_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.date "start_date"
    t.date "expected_arrival_date"
    t.integer "transport_type"
    t.string "starting_location"
    t.string "destination_location"
    t.integer "qr_code_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.string "start_lat"
    t.string "start_lon"
    t.string "destination_lat"
    t.string "destination_lon"
    t.uuid "exid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["exid"], name: "index_shipments_on_exid"
    t.index ["project_id"], name: "index_shipments_on_project_id"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "user_type", default: 1
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "pallet_scans", "pallets"
  add_foreign_key "pallets", "shipments"
  add_foreign_key "pallets", "users"
  add_foreign_key "scans", "shipments"
  add_foreign_key "shipments", "projects"
  add_foreign_key "shipments", "users"
end
