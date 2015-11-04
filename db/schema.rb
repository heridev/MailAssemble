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

ActiveRecord::Schema.define(version: 20151015221437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_lists", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "default_from"
    t.string   "default_from_name"
    t.text     "remind_people_message"
    t.string   "company_organization"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "state_province"
    t.string   "phone"
    t.string   "secure_key"
    t.string   "thank_you_page_url"
    t.string   "already_subscribed_url"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "follow_up_schedules", force: :cascade do |t|
    t.integer  "follow_up_id"
    t.integer  "subscriber_id"
    t.string   "state"
    t.datetime "run_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "follow_ups", force: :cascade do |t|
    t.text     "title"
    t.integer  "days_to_be_sent_after_previous", default: 1
    t.datetime "time_to_be_sent"
    t.text     "content"
    t.integer  "email_list_id"
    t.integer  "position"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "send_windows", force: :cascade do |t|
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.string   "hour"
    t.integer  "follow_up_id"
    t.integer  "hour_in_minutes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "subscribers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "email_list_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",     null: false
    t.integer  "item_id",       null: false
    t.string   "event",         null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "email_list_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
