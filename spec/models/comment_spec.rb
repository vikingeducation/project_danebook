require 'rails_helper'

describe Comment do 
  #let(:user){ create(:user) }
  let(:comment){ create(:comment) }


  # Happy
  it "is valid with default attributes" do
    expect(comment).to be_valid
  end


  it "responds to author assosiation" do
    expect(comment).to respond_to(:author)
  end

  it "responds to likes assosiation" do
    expect(comment).to respond_to(:likes)
  end

  # Sad
  it "deleted if author is deleted" do
    user = comment.author
    user.save
    comment.save
    user.destroy

    expect{Comment.find(comment.id)}.to raise_error
  end
end