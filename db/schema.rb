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

ActiveRecord::Schema.define(version: 20141025175515) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "author_id",                    null: false
    t.text     "content",                      null: false
    t.integer  "commentable_id",               null: false
    t.string   "commentable_type",             null: false
    t.integer  "likes_count",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", force: true do |t|
    t.integer  "likable_id",   null: false
    t.string   "likable_type", null: false
    t.integer  "liker_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likable_type", "likable_id", "liker_id"], name: "index_likes_on_likable_type_and_likable_id_and_liker_id", unique: true, using: :btree

  create_table "posts", force: true do |t|
    t.integer  "author_id",               null: false
    t.text     "content",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "likes_count", default: 0, null: false
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "school"
    t.string   "hometown"
    t.string   "current_town"
    t.string   "phone_number"
    t.text     "quotes"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "gender"
    t.date     "birthday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree

end
