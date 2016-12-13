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

ActiveRecord::Schema.define(version: 20161213064431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "text",                         null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "likes_count",      default: 0, null: false
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "initiator",  null: false
    t.integer  "recipient",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initiator", "recipient"], name: "index_friendships_on_initiator_and_recipient", unique: true, using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "likable_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "likable_type"
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id", using: :btree
    t.index ["user_id", "likable_type", "likable_id"], name: "index_likes_on_user_id_and_likable_type_and_likable_id", unique: true, using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "user_id",                        null: false
    t.integer  "likes_count",        default: 0, null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "text",                    null: false
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "college"
    t.string   "hometown"
    t.string   "address"
    t.string   "phone"
    t.text     "status"
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                    null: false
    t.string   "last_name",                     null: false
    t.string   "email",                         null: false
    t.string   "password_digest",               null: false
    t.string   "auth_token"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.date     "birthday",                      null: false
    t.integer  "gender_cd",                     null: false
    t.integer  "friendships_count", default: 0, null: false
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  end

end
