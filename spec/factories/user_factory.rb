FactoryGirl.define do 

	factory :user do
		sequence(:first_name) { |n| "foo#{n}" }
		last_name "bar"
		email {"#{first_name}@b.com"}
		gender "female"
		birthday "#{Time.now}"
		password "123456"
		password_confirmation "123456"
	
		trait :with_profile do 
			after(:build) { |user| user.profile = build(:profile)}
		end

	end

end

# -------
# create_table "users", force: :cascade do |t|
#   t.string   "username"
#   t.string   "email"
#   t.string   "password_digest"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
#   t.string   "first_name"
#   t.string   "last_name"
#   t.date     "birthday"
#   t.string   "gender"
# end

# trait :user_profile do
# 	after :create do |profile| 
# 		create 
# end