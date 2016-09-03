require 'rails_helper'

describe Post do
  let(:postb){ build(:post)}
  let(:postc){ create(:post)}

  it "requires body and author id to be valid" do
    expect(postb).to be_valid
  end
  it "has association author" do
    expect(postc).to respond_to(:author)
  end
  it "has many likes" do
    expect(postc).to respond_to(:likes)
  end
  it "has many likers" do
    expect(postc).to respond_to(:likers)
  end
  it "has many comments" do
    expect(postc).to respond_to(:comments)
  end
  it "has many commenters" do
    expect(postc).to respond_to(:commenters)
  end




end
