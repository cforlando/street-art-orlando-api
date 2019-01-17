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


ActiveRecord::Schema.define(version: 20190106021753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "submission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submission_id"], name: "index_favorites_on_submission_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "submission_id"
    t.bigint "user_id"
    t.string "status", default: "pending"
    t.text "reason"
    t.text "moderation_note"
    t.string "ip_address"
    t.string "device_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_identifier"], name: "index_reports_on_device_identifier"
    t.index ["status"], name: "index_reports_on_status"
    t.index ["submission_id"], name: "index_reports_on_submission_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.text "description"
    t.string "photo"
    t.string "status", default: "processing"
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.text "location_note"
    t.string "ip_address"
    t.string "app_version"
    t.string "device_model"
    t.string "system_version"
    t.string "device_locale"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rejected_reason"
    t.datetime "status_email_sent_at"
    t.index ["artist"], name: "index_submissions_on_artist"
    t.index ["status"], name: "index_submissions_on_status"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_sent_at"
    t.boolean "vip", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "disabled", default: false
    t.string "nickname"
  end

end
