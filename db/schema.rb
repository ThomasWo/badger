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

ActiveRecord::Schema.define(version: 20150511004203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "company"
    t.string   "twitter_handle"
    t.string   "shirt_size"
    t.text     "dietary_restrictions"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "event_id"
    t.integer  "role_id"
    t.boolean  "exported"
    t.boolean  "checked_in",           default: false
  end

  add_index "attendees", ["event_id"], name: "index_attendees_on_event_id", using: :btree
  add_index "attendees", ["role_id"], name: "index_attendees_on_role_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "border_color"
    t.boolean  "show_company"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "sponsor_companies", force: :cascade do |t|
    t.string   "company"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sponsor_companies", ["event_id"], name: "index_sponsor_companies_on_event_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.boolean  "admin",                  default: false
    t.boolean  "super_admin",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "attendees", "events"
  add_foreign_key "attendees", "roles"
  add_foreign_key "sponsor_companies", "events"
end
