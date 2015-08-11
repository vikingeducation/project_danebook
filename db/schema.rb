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

ActiveRecord::Schema.define(version: 20150811051758) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "post_id",    null: false
    t.string   "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendings", force: :cascade do |t|
    t.integer  "friend_id",   null: false
    t.integer  "friender_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendings", ["friend_id", "friender_id"], name: "index_friendings_on_friend_id_and_friender_id", unique: true

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "likable_id",   null: false
    t.string   "likable_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "likes", ["likable_id", "likable_type"], name: "index_likes_on_likable_id_and_likable_type"

  create_table "photos", force: :cascade do |t|
    t.string   "user_photo_file_name"
    t.string   "user_photo_content_type"
    t.integer  "user_photo_file_size"
    t.datetime "user_photo_updated_at"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "birthday_month"
    t.integer  "birthday_day"
    t.integer  "birthday_year"
    t.string   "gender"
    t.string   "hometown"
    t.string   "current_lives"
    t.string   "telephone"
    t.string   "words_to_live_by"
    t.string   "about_me"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "college"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true

end
