# B. Post

# 2. Create
# Only wall owner can create a post on own wall *

# 3. Destroy
# Can only be destroyed by creator *

# 4. Associations
# Has many comments *
# Destroying a post will destroy associated comments *

require 'pry'
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
	
	context "destroy" do

		it "can only be by owner"

	end

end