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

ActiveRecord::Schema.define(version: 20160609134444) do

  create_table "likings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likings", ["user_id", "post_id"], name: "index_likings_on_user_id_and_post_id", unique: true

  create_table "posts", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "first_name",                        null: false
    t.string   "last_name",                         null: false
    t.string   "birth_month",                       null: false
    t.string   "birth_day",                         null: false
    t.string   "birth_year",                        null: false
    t.string   "gender",                            null: false
    t.string   "college",         default: "empty", null: false
    t.string   "hometown",        default: "empty", null: false
    t.string   "current_address", default: "empty", null: false
    t.string   "phone",           default: "empty", null: false
    t.string   "my_words",        default: "empty", null: false
    t.string   "about_me",        default: "empty", null: false
    t.integer  "user_id",                           null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
