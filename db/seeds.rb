# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# MULT=30
#   create_table "profiles", force: :cascade do |t|
#     t.integer  "user_id"
#     t.string   "email"
#     t.string   "college"
#     t.string   "phone"
#     t.string   "hometown"
#     t.string   "homecountry"
#     t.string   "livesintown"
#     t.string   "livesincountry"
#     t.string   "wordsby"
#     t.string   "wordsabout"
#     t.datetime "created_at",     null: false
#     t.datetime "updated_at",     null: false
#   end
# MULT.times do 
#   User.create()
#   create_table "users", force: :cascade do |t|
#     t.string   "email"
#     t.string   "first_name"
#     t.string   "last_name"
#     t.date     "birthday"
#     t.string   "gender"
#     t.datetime "created_at",      null: false
#     t.datetime "updated_at",      null: false
#     t.string   "password_digest"
#   end