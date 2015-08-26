require 'rails_helper'

describe Post do
  let(:post){build(:post)}

  it "has a user id" do
    expect(post.user_id).to eq(1)
  end

  it "raises an error if no user id provided" do
    post.user_id = nil
    expect(post).not_to be_valid
  end

  it "responds to the posts association" do
    expect(post).to respond_to(:comments)
  end

end