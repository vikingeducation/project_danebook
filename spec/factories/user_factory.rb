# create_table "users", force: :cascade do |t|
#   t.string   "email"
#   t.string   "password_digest"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
#   t.string   "auth_token"
#   t.string   "first_name"
#   t.string   "last_name"
#   t.string   "gender"
#   t.text     "words_to_live"
#   t.text     "about_me"
#   t.datetime "birthday"
#   t.string   "college"
#   t.string   "hometown"
#   t.string   "current_add"
#   t.string   "tele"
#   t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
#   t.index ["email"], name: "index_users_on_email", using: :btree
#   t.index ["password_digest"], name: "index_users_on_password_digest", using: :btree
# end

FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:email) { |n| "aol#{n}@aol.com" }
    first_name "Fake"
    last_name "User"
    gender "Male"
    birthday Time.now
    sequence(:password) { |n| "abcdefg#{n}"}

  end

end
