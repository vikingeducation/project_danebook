require 'rails_helper'

describe Post do

  let(:post) { build(:post) }

  describe "attributes" do
    it "invalidates a nil body" do
      new_post = build(:post, body: nil)
      expect(new_post).to_not be_valid
    end

    it "allows with a body below 2000 characters" do
      expect(post).to be_valid
    end

    it "invalidates body over character limit of 2000" do
      new_post = build(:post, body: "a" * 2001)
      expect(new_post).to_not be_valid
    end
  end

  describe "associations" do
    it "responds to the likes association" do
      expect(post).to respond_to(:likes)
    end

    it "responds to the comments association" do
      expect(post).to respond_to(:comments)
    end

    context "User associations" do
      it "responds to the user association" do
        expect(post).to respond_to(:user)
      end

      it "linking a valid user succeeds" do
        user = create(:user)
        post.user = user
        expect { post.save }.to_not raise_error
      end

      it "linking nonexistent user fails" do
        post.user_id = 1234
        expect( post ).to_not be_valid
      end
    end
  end

end
