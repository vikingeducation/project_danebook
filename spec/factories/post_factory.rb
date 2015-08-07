FactoryGirl.define do
	
	factory :post do
		body "Hello there"
		user
	end

end

	# -----------
  # create_table "posts", force: :cascade do |t|
  #   t.text     "body"
  #   t.integer  "user_id"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  # end