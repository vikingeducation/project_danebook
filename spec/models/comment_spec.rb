require 'rails_helper'

describe Comment do
  let(:comment_comment){create(:comment_comment)}

  describe "associations" do 
    let(:comment) {create(:comment)}
    
    it "belongs to itself" do 
      is_expected.to belong_to(:commentable)
    end

    it "should return the commentable" do 
      expect(comment_comment).to respond_to(:commentable)
    end
  end

end