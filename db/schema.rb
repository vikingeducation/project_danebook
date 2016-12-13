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

ActiveRecord::Schema.define(version: 20161211173051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bios", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "slogan"
    t.text     "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_bios_on_profile_id", using: :btree
  end

  create_table "friend_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_friend_requests_on_user_id", using: :btree
  end

  create_table "friends_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_users_on_friend_id", using: :btree
    t.index ["user_id"], name: "index_friends_users_on_user_id", using: :btree
  end

  create_table "galleries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_galleries_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "gallery_id"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["gallery_id"], name: "index_images_on_gallery_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "user_id"], name: "index_likes_on_post_id_and_user_id", unique: true, using: :btree
    t.index ["post_id"], name: "index_likes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_likes_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "post_type",      default: "Post"
    t.integer  "post_id"
    t.text     "body"
    t.integer  "likes_count",    default: 0
    t.integer  "comments_count", default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "gender"
    t.string   "college"
    t.string   "hometown"
    t.string   "current_home"
    t.string   "phone"
    t.integer  "image_id"
    t.integer  "cover"
    t.boolean  "edited",       default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "token"
    t.integer  "failed"
    t.datetime "last_attempt"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "friend_requests", "users"
  add_foreign_key "friends_users", "users"
  add_foreign_key "galleries", "users"
  add_foreign_key "images", "galleries"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
end
