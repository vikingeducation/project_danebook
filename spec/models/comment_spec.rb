require 'rails_helper'

describe Comment do

let(:comment){build(:comment)}

it "should be valid" do
  expect(comment).to be_valid
end

it "should belong to a post" do
  expect(comment.post_id).not_to be_nil
end

it "should not be empty" do
  comment.body = ""
  expect(comment).not_to be_valid
end


end