require 'rails_helper'

describe Like do

let(:post_like){build(:post_like)}
let(:comment_like){build(:comment_like)}

it "should be valid" do
  expect(post_like).to be_valid
end

it "likes on posts should belong to a post" do
  expect(post_like.likeable).to be_a(Post)
end

it "likes on comments should belong to a comment" do
  expect(comment_like.likeable).to be_a(Comment)
end

end