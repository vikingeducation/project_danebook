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

ActiveRecord::Schema.define(version: 20160819192645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string   "type"
    t.text     "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "from"
    t.integer  "user_id"
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "from"
    t.index ["likeable_id", "likeable_type"], name: "index_likes_on_likeable_id_and_likeable_type", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "from"
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "month"
    t.integer  "year"
    t.integer  "day"
    t.string   "college"
    t.string   "hometown"
    t.string   "current_location"
    t.string   "telephone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "about_me"
    t.text     "words_to_live_by"
    t.date     "birthday"
    t.integer  "cover_photo_id"
    t.integer  "profile_photo_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
end
