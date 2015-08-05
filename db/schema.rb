

ActiveRecord::Schema.define(version: 20150805185656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "body"
    t.integer  "commenting_id"
    t.integer  "commenting_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "comments", ["commenting_type", "commenting_id"], name: "index_comments_on_commenting_type_and_commenting_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "college"
    t.string   "phone"
    t.string   "hometown"
    t.string   "homecountry"
    t.string   "livesintown"
    t.string   "livesincountry"
    t.string   "wordsby"
    t.string   "wordsabout"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "gender"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
