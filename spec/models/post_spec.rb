require 'rails_helper'

describe Post do

let(:post){build(:post)}

it "should be valid" do
  expect(post).to be_valid
end

it "should have a profile_id" do
  post.profile_id = nil
  expect(post).not_to be_valid 
end


it "should have a user_id" do
  post.user_id = nil
  expect(post).not_to be_valid 
end

it "should not be empty" do
  post.body = ""
  expect(post).not_to be_valid
end


end