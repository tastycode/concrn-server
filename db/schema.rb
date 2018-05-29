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

ActiveRecord::Schema.define(version: 20180529020757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "affiliates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "survey_url"
  end

  create_table "devices", force: :cascade do |t|
    t.string "user_id"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dispatches", force: :cascade do |t|
    t.string "dispatch_type"
    t.integer "user_id"
    t.integer "responder_id"
    t.integer "report_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_fences", force: :cascade do |t|
    t.integer "fenceable_id"
    t.string "fenceable_type"
    t.integer "radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.point "coordinates"
  end

  create_table "referrals", force: :cascade do |t|
    t.integer "user_id"
    t.integer "report_id"
    t.integer "affiliate_id"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_events", force: :cascade do |t|
    t.integer "report_id"
    t.string "event_type"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_notes", force: :cascade do |t|
    t.integer "report_id"
    t.integer "user_id"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reporters", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.string "address"
    t.string "reporter_notes"
    t.string "responder_reporter_notes"
    t.string "responder_internal_notes"
    t.boolean "is_harm_immediate"
    t.integer "reporter_id"
    t.integer "responder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "source"
    t.string "zip"
    t.point "coordinates"
    t.string "google_place_id"
  end

  create_table "responders", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "token"
    t.datetime "token_issued_at"
    t.string "refresh_token"
    t.string "password_digest"
    t.string "affiliate_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.integer "affiliate_id"
  end

  create_table "zip_fences", force: :cascade do |t|
    t.integer "fenceable_id"
    t.string "fenceable_type"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
