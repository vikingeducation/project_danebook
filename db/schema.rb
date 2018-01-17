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

ActiveRecord::Schema.define(version: 20180117220641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body",             default: "", null: false
    t.integer  "user_id"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "friendings", force: :cascade do |t|
    t.integer  "initiator_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["initiator_id", "recipient_id"], name: "index_friendings_on_initiator_id_and_recipient_id", unique: true, using: :btree
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id", "likeable_type", "likeable_id"], name: "index_likes_on_user_id_likeable_id_likeable_type", unique: true, using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.text     "body",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           default: "", null: false
    t.string   "password_digest"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",            default: "", null: false
    t.date     "birthday"
    t.string   "hometown",        default: "", null: false
    t.string   "current_town",    default: "", null: false
    t.string   "college",         default: "", null: false
    t.string   "phone",           default: "", null: false
    t.text     "quote",           default: "", null: false
    t.text     "bio",             default: "", null: false
    t.string   "headshot_pic",    default: "", null: false
    t.string   "cover_pic",       default: "", null: false
  end

  add_foreign_key "comments", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "posts", "users"
end
