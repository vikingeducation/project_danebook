require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ build(:user) }

  describe "attributes" do
    it "is valid with default attributes" do
      expect(user).to be_valid
    end

    it "saves with default attributes" do
      expect{ user.save! }.not_to raise_error
    end

    context "when saving multiple users" do
      before do
        user.save!
      end
      it "doesn't allow identical email addresses" do
        new_user = build(:user, :email => user.email)
        expect(new_user).not_to be_valid
      end
    end

    it "with a name and email is valid" do
      expect(user).to be_valid
    end

    it "without a name is invalid" do
      user = build(:user, :name => nil)
      expect(user).not_to be_valid
    end

    it "without an email address is invalid" do
      user = build(:user, :email => nil)
      expect(user).not_to be_valid
    end

    it "returns a user's name as a string" do
      expect(user.name.is_a?(String)).to be == true
    end
  end #attributes

  describe "Authorship associations" do
    let( :post ) { create( :post ) }

    specify "linking a valid Author succeeds" do
      user = create( :user )
      post.user = user
      expect( post ).to be_valid
    end

    specify "linking nonexistent author fails" do
      post.user_id = 1234
      expect( post ).not_to be_valid
    end

    it "responds to the posts association" do
      expect(user).to respond_to(:posts)
      expect(user).to respond_to(:authored_posts)
    end
  end

  describe "polymorphic commenting associations" do
    let( :post_comment ) { create( :comment_on_post ) }
    let( :comment_comment ) { create( :comment_on_comment ) }

    specify "comments respond to their parent post association" do
      expect( post_comment ).to respond_to( :commentable )
    end

    specify "comments respond to their parent comment association" do
      expect( comment_comment ).to respond_to( :commentable )
    end

  end

  describe "#post_count" do

    let(:num_posts){ 3 }

    before do
      user.posts = create_list(:post, num_posts)
      user.save!
    end

    it "returns the count of a User's posts" do
      expect(user.post_count).to eq(num_posts)
    end
  end # post_count

end
