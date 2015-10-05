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