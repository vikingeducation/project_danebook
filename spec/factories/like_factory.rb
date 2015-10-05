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