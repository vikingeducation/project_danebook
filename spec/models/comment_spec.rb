require 'rails_helper'

describe Comment do
  let(:commentb) { build(:comment)}
  let(:commentc) { create(:comment)}

  it "responds to association #commenter" do
    expect(commentc).to respond_to(:commenter)
  end
  it "has polymorphic assocation #commentable" do
    expect(commentc).to respond_to(:commentable)
  end

  it "has assocation #likes" do
    expect(commentc).to respond_to(:likes)
  end
  it "has assocation #likers" do
    expect(commentc).to respond_to(:likers)
  end
  it "requires commentable_id, commenter_id, and body to be valid" do
    expect(commentb).to be_valid 
  end

end
