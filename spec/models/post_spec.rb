require 'rails_helper'

describe Post do

let(:post){build(:post)}

it "should be valid" do
  expect(post).to be_valid
end

it "should belong to a profile" do
  expect(post.profile).not_to be_nil
end

it "should not be empty" do
  post.body = ""
  expect(post).not_to be_valid
end


end