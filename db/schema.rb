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

ActiveRecord::Schema.define(version: 20141030205543) do

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"

  create_table "posts", force: true do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id"

  create_table "profiles", force: true do |t|
    t.integer  "user_id",      null: false
    t.string   "hometown"
    t.string   "current_city"
    t.string   "telephone"
    t.text     "description"
    t.text     "life_words"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                       null: false
    t.string   "fname",                       null: false
    t.string   "lname",                       null: false
    t.string   "password_digest",             null: false
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
    t.date     "birthday",        limit: 255
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
