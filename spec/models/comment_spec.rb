require 'rails_helper'

describe Comment do 
  let(:user){ build(:user) }
  let(:comment){ build(:comment) }


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
    user.destroy
    expect(comment.nil?).to eq(true)
  end
end