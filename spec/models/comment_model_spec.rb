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


require 'pry'
require 'rails_helper'

describe Comment do

	let(:comment){build(:comment)}

	context "creation"  do
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
			comment.save!
			comment2 = build(:comment)
			comment2.commentable_type = "Comment"
			comment2.commentable_id = comment.id
			binding.pry
			expect(comment2).to be_valid
		end

		it "can comment on a post" do 
			post = create(:post)
			comment.commentable_type = post.class
			comment.commentable_id = post.id
			expect(comment).to be_valid
		end

	end

	context "associations" do

	end

	

end