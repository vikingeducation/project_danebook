# 1. Create
# Requires a user to be created *
# Requires a body *
# A comment is polymorphic *
# A comment can comment on another comment *
# A comment can comment on a post *

# 3. Associations
# Has many likes * 
# Has many users_liking_comments *

# 4. Methods
# Count likes accurately returns number of likes on a comment *

require 'rails_helper'

describe Comment do

	context "creation"  do

		let(:comment){build(:comment)}

		it "requires a user before creation" do
			expect(comment.user.persisted?).to be_truthy  
		end

		it "requires a body" do
			comment.body = nil 
			expect(comment).to be_invalid
		end

	end

	context "polymorphism" do 

		it "can comment on a comment" do 
			comment = build(:comment_comment)
			expect(comment).to be_valid
		end

		it "can comment on a post" do 
			comment = create(:post_comment)
			expect(comment).to be_valid
		end

	end

	context "associations" do
		
		let(:comment){build(:comment_comment)}

		it "should respond to likes" do
			expect(comment).to respond_to(:likes)
		end

		it "should respond to users liking comments" do
			expect(comment).to respond_to(:users_liking_comment)
		end

		it "should respond to comments" do 
			expect(comment).to respond_to(:comments)
		end

		it "should respond to user" do 
			expect(comment).to respond_to(:user)
		end

	end

	context "methods" do
		xit "should count 5 likes for a comment with 5 likes" do
			new_comment = create(:comment_comment)
			new_comment.likes = build_list(:like_comment, 5, 
																			:liking_id => new_comment.id,
																			:liking_type => new_comment.class)
			new_comment.save!
			# binding.pry
			expect(new_comment.count_likes).to eq(5)
		end

		xit "should count 3 likes for a comment on a post that has 3 likes" do
			new_post_comment = create(:post_comment)
			new_post_comment.likes = create_list(:like_comment, 3)
			expect(new_post_comment.count_likes).to eq(3)
		end 
	
	end
	
end