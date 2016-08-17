require 'rails_helper'

describe Like do
  let(:post_like) { create(:post_like) }
  let(:comment_like) { create(:comment_like) }

  describe "Validations" do
    it "creates a like with valid attributes" do
      expect(post_like).to be_valid
    end

    it "will not like invalid types" do
      invalid_types = ["User", "City", "Like"]
      invalid_types.each do |invalid_type|
        post_like.likable_type = invalid_type
        expect(post_like).to_not be_valid
      end
    end
  end

  describe "Associations" do
    it "belongs to a user" do
      is_expected.to belong_to :user
    end

    it "responds to likable" do
      expect(post_like).to respond_to :likable
    end

    specify "linking a valid user succeeds" do
      user = create( :user )
      post_like.user = user
      expect( post_like ).to be_valid
    end

    specify "linking nonexistent user fails" do
      post_like.user_id = 1234
      expect( post_like ).not_to be_valid
    end

    specify "linking a valid likable succeeds" do
      likable = create( :post )
      post_like.likable = likable
      expect( post_like ).to be_valid
    end

    specify "linking nonexistent likable fails" do
      post_like.likable_id = 1234
      expect( post_like ).not_to be_valid
    end
  end

end
