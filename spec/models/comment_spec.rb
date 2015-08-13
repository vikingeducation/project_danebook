require 'rails_helper'

describe Comment do
  let(:comment){build(:comment)}

  it "has a user id" do
    expect(comment.user_id).to eq(1)
  end

  it "raises an error if no user id provided" do
    comment.user_id = nil
    expect(comment).not_to be_valid
  end

  it "responds to likes" do
    expect(comment).to respond_to(:likes)
  end

  it "has a user" do
    expect(comment).to respond_to(:user)
  end


end
