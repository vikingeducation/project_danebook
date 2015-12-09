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

ActiveRecord::Schema.define(version: 20151208161138) do

  create_table "activities", force: :cascade do |t|
    t.string   "verb"
    t.integer  "user_id"
    t.integer  "feedable_id"
    t.string   "feedable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["feedable_id"], name: "index_activities_on_feedable_id"
  add_index "activities", ["feedable_type"], name: "index_activities_on_feedable_type"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"
  add_index "activities", ["verb"], name: "index_activities_on_verb"

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

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
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "friend_requests", force: :cascade do |t|
    t.integer  "initiator_id"
    t.integer  "approver_id"
    t.boolean  "approved"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "friend_requests", ["approver_id"], name: "index_friend_requests_on_approver_id"
  add_index "friend_requests", ["initiator_id", "approver_id"], name: "index_friend_requests_on_initiator_id_and_approver_id", unique: true
  add_index "friend_requests", ["initiator_id"], name: "index_friend_requests_on_initiator_id"

  create_table "friendships", force: :cascade do |t|
    t.integer  "initiator_id"
    t.integer  "approver_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "friendships", ["approver_id"], name: "index_friendships_on_approver_id"
  add_index "friendships", ["initiator_id", "approver_id"], name: "index_friendships_on_initiator_id_and_approver_id", unique: true
  add_index "friendships", ["initiator_id"], name: "index_friendships_on_initiator_id"

  create_table "genders", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name", limit: 32
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "genders", ["name"], name: "index_genders_on_name"
  add_index "genders", ["short_name"], name: "index_genders_on_short_name"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["likeable_id"], name: "index_likes_on_likeable_id"
  add_index "likes", ["likeable_type"], name: "index_likes_on_likeable_type"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "photos", ["user_id"], name: "index_photos_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "college"
    t.string   "hometown"
    t.string   "currently_lives"
    t.string   "telephone"
    t.text     "words_to_live_by"
    t.text     "about_me"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "profiles", ["college"], name: "index_profiles_on_college"
  add_index "profiles", ["currently_lives"], name: "index_profiles_on_currently_lives"
  add_index "profiles", ["hometown"], name: "index_profiles_on_hometown"
  add_index "profiles", ["telephone"], name: "index_profiles_on_telephone"
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "gender_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["birthday"], name: "index_users_on_birthday"
  add_index "users", ["cover_photo_id"], name: "index_users_on_cover_photo_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["first_name"], name: "index_users_on_first_name"
  add_index "users", ["gender_id"], name: "index_users_on_gender_id"
  add_index "users", ["last_name"], name: "index_users_on_last_name"
  add_index "users", ["profile_photo_id"], name: "index_users_on_profile_photo_id"

end
