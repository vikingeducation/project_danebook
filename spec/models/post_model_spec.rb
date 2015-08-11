require 'rails_helper'

describe Post do

	let(:post){build(:post)}

	context "create" do

		specify "only by profile owner"

		it "must have a body" do
			post.body = nil
			expect(post).to be_invalid
		end

		it "must have a user" do
			post.user = nil
			expect(post).to be_invalid
		end

	end

	context "associations" do

		it "should respond to likes" do
			expect(post).to respond_to(:likes)
		end

		it "should respond to liked by" do
			expect(post).to respond_to(:liked_by)
		end

		it "should respond to liked by" do
			expect(post).to respond_to(:comments)
		end

	end

	context "methods" do

		specify "count likes returns number of likes" do
			post.likes = create_list(:like_post, 1)
			post.save!
			expect(post.count_likes).to eq(1)
		end

		it "should count 3 likes for a post that has 3 likes" do
			post.likes = create_list(:like_post, 3)
			post.save!
			expect(post.count_likes).to eq(3)
		end

	end
end