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

ActiveRecord::Schema.define(version: 20161216215421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "author_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "post_id"
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
  end

  create_table "friendings", force: :cascade do |t|
    t.integer "friender_id"
    t.integer "friended_id"
    t.index ["friender_id", "friended_id"], name: "index_friendings_on_friender_id_and_friended_id", using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "liker_id"
    t.string   "likable_thing_type"
    t.integer  "likable_thing_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["likable_thing_type", "likable_thing_id"], name: "index_likes_on_likable_thing_type_and_likable_thing_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "owner_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "photo_data_file_name"
    t.string   "photo_data_content_type"
    t.integer  "photo_data_file_size"
    t.datetime "photo_data_updated_at"
    t.index ["owner_id"], name: "index_photos_on_owner_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "birthday"
    t.string   "gender"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "college"
    t.string   "hometown"
    t.string   "city"
    t.string   "telephone"
    t.text     "words_to_live_by"
    t.text     "about_me"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  end

  add_foreign_key "posts", "users", column: "author_id"
end
