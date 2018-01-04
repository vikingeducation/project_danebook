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

ActiveRecord::Schema.define(version: 20180103224107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
