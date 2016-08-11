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

ActiveRecord::Schema.define(version: 20160811183246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.string   "address_1"
    t.string   "address_2"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  add_index "addresses", ["city_id"], name: "index_addresses_on_city_id", using: :btree
  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id", using: :btree

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "birthdays", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "birthdays", ["profile_id"], name: "index_birthdays_on_profile_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_infos", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contact_infos", ["profile_id"], name: "index_contact_infos_on_profile_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hometowns", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "hometowns", ["profile_id"], name: "index_hometowns_on_profile_id", using: :btree

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "profile_dates", force: :cascade do |t|
    t.integer  "dateable_id"
    t.string   "dateable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "month"
    t.integer  "day"
    t.integer  "year"
  end

  add_index "profile_dates", ["dateable_type", "dateable_id"], name: "index_profile_dates_on_dateable_type_and_dateable_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "words"
    t.string   "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.string   "college"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "residences", force: :cascade do |t|
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "residences", ["profile_id"], name: "index_residences_on_profile_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "testings", force: :cascade do |t|
    t.string   "name"
    t.string   "forest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "testings", ["forest"], name: "index_testings_on_forest", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "friendable_id"
    t.string   "friendable_type"
  end

  add_index "users", ["friendable_type", "friendable_id"], name: "index_users_on_friendable_type_and_friendable_id", using: :btree

  create_table "users_practice", id: false, force: :cascade do |t|
    t.integer  "id"
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "states"
  add_foreign_key "birthdays", "profiles"
  add_foreign_key "contact_infos", "profiles"
  add_foreign_key "hometowns", "profiles"
  add_foreign_key "microposts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "residences", "profiles"
end
