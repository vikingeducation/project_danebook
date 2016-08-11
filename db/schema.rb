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

ActiveRecord::Schema.define(version: 20160811232116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "gender"
    t.string   "telephone",       default: ""
    t.string   "quote",           default: ""
    t.text     "about",           default: ""
    t.string   "college",         default: ""
    t.integer  "hometown_id"
    t.integer  "curr_addr_id"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  end

end
