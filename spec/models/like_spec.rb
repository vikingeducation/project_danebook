require 'rails_helper'

describe Like do

  let(:user){create(:user)}
  let(:post){user.posts_written.create(attributes_for(:post))}
  let(:comment){user.comments_written.create(attributes_for(:comment, commentable_id: post.id) )}
  let(:comment_like){user.likes_given.create(attributes_for(:comment_like, likeable_id: comment.id))}
  let(:post_like){user.likes_given.create(attributes_for(:post_like, likeable_id: post.id))}

  it "should be valid with valid attributes" do
    expect(comment_like).to be_valid
  end

  it "should be valid with valid attributes" do
    expect(post_like).to be_valid
  end

  it {should belong_to(:user)}

  it { should belong_to(:likeable)}

  it "should find the correct path for its type" do
    expect(Like.find_likable_type("/comments/1/like")).to eq("Comment")
    expect(Like.find_likable_type("/posts/1/like")).to eq("Post")
  end








end