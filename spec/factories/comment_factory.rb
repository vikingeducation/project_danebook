FactoryGirl.define do
	
	factory :comment do 
		
		body "I am a comment"
		# commentable_id 
		# commentable_type 
		user
	end

end 


# ----------
#   create_table "comments", force: :cascade do |t|
#     t.integer  "user_id"
#     t.text     "body"
#     t.integer  "commentable_id"
#     t.string   "commentable_type"
#     t.datetime "created_at",       null: false
#     t.datetime "updated_at",       null: false
#   end