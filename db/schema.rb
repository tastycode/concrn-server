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

ActiveRecord::Schema.define(version: 20180523144712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliates", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "user_id"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "point_fences", force: :cascade do |t|
    t.integer "fenceable_id"
    t.string "fenceable_type"
    t.decimal "lat"
    t.decimal "long"
    t.integer "radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_actions", force: :cascade do |t|
    t.integer "report_id"
    t.string "action"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reporters", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.decimal "lat"
    t.decimal "long"
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
  end

  create_table "responders", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "token"
    t.datetime "token_issued_at"
    t.string "refresh_token"
    t.string "password_digest"
    t.string "affiliate_id"
    t.string "affiliate_role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
  end

  create_table "zip_fences", force: :cascade do |t|
    t.integer "fenceable_id"
    t.string "fenceable_type"
    t.string "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
