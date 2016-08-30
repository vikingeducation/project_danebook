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

ActiveRecord::Schema.define(version: 20160830002216) do

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type"
    t.integer  "commenter_id",     null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "body",             null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "likable_id",   null: false
    t.integer  "liker_id",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "likable_type"
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "gender",          null: false
    t.integer  "b_month",         null: false
    t.integer  "b_day",           null: false
    t.integer  "b_year",          null: false
    t.string   "home"
    t.string   "lives"
    t.string   "phone"
    t.string   "college"
    t.text     "words"
    t.text     "bio"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
  end

end
