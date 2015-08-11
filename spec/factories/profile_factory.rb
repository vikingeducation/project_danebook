FactoryGirl.define do

	factory :profile do
		about_me "a sentence about me"
		words_to_live_by "my words to live by"
		home_city "my home city"
		home_country "my home country"
		college "what's that"
		user
	end

end

# ---------
# create_table "profiles", force: :cascade do |t|
#   t.text     "about_me"
#   t.text     "words_to_live_by"
#   t.string   "home_city"
#   t.string   "home_country"
#   t.string   "current_city"
#   t.string   "current_country"
#   t.datetime "created_at",       null: false
#   t.datetime "updated_at",       null: false
#   t.integer  "user_id"
#   t.string   "college"
#   t.string   "telephone"
# end