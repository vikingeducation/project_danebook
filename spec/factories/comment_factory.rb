FactoryGirl.define do

	factory :comment do

		body "I am a comment"
		user

		factory :post_comment do
			after(:build) do |comment|
				comment.commentable = build(:post)  # commentable assigns both commentable type and id
			end
		end

		factory :comment_comment do
			after(:build) do |comment|
				comment.commentable = build(:comment)
			end
		end

	end
end

# ----------
# create_table "comments", force: :cascade do |t|
#   t.integer  "user_id"
#   t.text     "body"
#   t.integer  "commentable_id"
#   t.string   "commentable_type"
#   t.datetime "created_at",       null: false
#   t.datetime "updated_at",       null: false
# end











		# before(:create) do |comment|
		# 	# comment.commentable = create(:post)
		# end

		# after(:build) do |comment|
		# 	comment.post = build(:post, :comment => comment)
		# 	comment.comment = build(:comment, :comment => comment)
		# end

		# after(:create) do |comment|
		# 	comment.post.save!
		# 	comment.comment.save!
		# end