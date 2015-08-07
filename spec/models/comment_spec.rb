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

end
