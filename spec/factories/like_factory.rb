FactoryGirl.define do 

	factory :like do
		
		user

		factory :like_post do 
			after(:build) do |like|
				like.liking = build(:post) # liking assigns both type and id as post.id and post.class
			end
		end
	
		factory :like_comment do 
			after(:build) do |like|
				like.liking = build(:comment)
			end
		end

	end
	
end

# -------
#   create_table "likes", force: :cascade do |t|
#     t.integer  "user_id"
#     t.datetime "created_at",  null: false
#     t.datetime "updated_at",  null: false
#     t.string   "liking_type"
#     t.integer  "liking_id"
#   end