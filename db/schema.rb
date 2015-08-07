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

ActiveRecord::Schema.define(version: 20150806220444) do

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "post_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "duty_id"
    t.string   "duty_type"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["duty_id", "duty_type"], name: "index_likes_on_duty_id_and_duty_type"

  create_table "posts", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id",    null: false
    t.integer  "posted_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.date     "birthday"
    t.string   "college"
    t.string   "hometown"
    t.string   "current_town"
    t.string   "telephone"
    t.string   "words_to_live_by"
    t.string   "about_me"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "photo_url"
    t.string   "background_url"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 23, null: false
    t.string   "last_name",       limit: 23, null: false
    t.string   "email",           limit: 23, null: false
    t.string   "password_digest",            null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true

end
