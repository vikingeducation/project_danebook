require 'rails_helper'

describe Post do

  describe "Validations" do 

    let(:post) { create(:post) }

    it "validates the presence of content" do 
      is_expected.to validate_presence_of(:content)
    end

    it "validates the length of the post" do 
      is_expected.to validate_length_of(:content).is_at_least(1)
    end

    it "has a database column for user ids" do 
      is_expected.to have_db_column(:user_id)
    end

  end

  describe "Associations" do 

    let(:post) {create(:post)}

    it "accepts nested attributes for a comment" do 
      is_expected.to accept_nested_attributes_for(:comments)
    end

    it "only has one user" do 
      is_expected.to belong_to(:user)
    end

    it "has many comments" do 
      is_expected.to have_many(:comments)
    end

    it "has many likes" do 
      is_expected.to have_many(:likes)
    end
    it "should return the comments" do 
      expect(post).to respond_to(:comments)
    end
  end

  describe "#all_comments" do 
    let(:post) {create(:post)}
    
    it "should list all comments in ascending order of a comment" do
      5.times do |n| 
        post.comments.build(created_at: Time.now)
      end
      post.comments.each_with_index do |comment, index|
        expect(comment.created_at).to be < post.comments[index + 1].created_at if post.comments[index + 1]
      end
    end

    it "returns a list of all comments by the person" do 
      10.times do |n|
        post.comments.build(content: n)
      end
      all_comments = post.comments.length
      expect(all_comments).to eq(10)
    end
  end

end