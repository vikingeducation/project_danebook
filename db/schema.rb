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

ActiveRecord::Schema.define(version: 20160818210314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "friender_id"
    t.integer  "friended_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendships", ["friender_id", "friended_id"], name: "index_friendships_on_friender_id_and_friended_id", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "likes", ["likable_type", "likable_id", "user_id"], name: "index_likes_on_likable_type_and_likable_id_and_user_id", unique: true, using: :btree
  add_index "likes", ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "college"
    t.string   "hometown"
    t.string   "currently_lives"
    t.string   "telephone"
    t.text     "life_words"
    t.text     "about_me"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.date     "birth_date"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "tasks", force: :cascade do |t|
    t.text     "description"
    t.datetime "due_date"
    t.string   "category"
    t.integer  "priority"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "pinned"
    t.boolean  "completed",   default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "gender"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree

end
