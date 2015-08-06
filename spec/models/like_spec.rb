require 'rails_helper'
require 'support/factory_girl'

describe Like do

  let(:user){build(:user)}
  let(:post_like){build(:post_like)}
  let(:comment_like){build(:comment_like)}
  # before(:each) do
  #   @liked_post = FactoryGirl.create(:post_like)
  #   @post = @liked_post.post
  # end
  xit "cannot be liked by the same user twice" do
    post_like.likeable_id = 15
    post_like.save
    new_like = build(:post_like, likeable_id: 15, likeable_type: "Post")
    expect(new_like).not_to be_valid
  end

  xit "can be added to a post" do
    # allow(post).to receive(:like).and_return()
    expect(@post.like).to be_valid
  end

  xit "cannot like something that the same user already liked" do
    expect{@post.like}.to raise_error
  end


end