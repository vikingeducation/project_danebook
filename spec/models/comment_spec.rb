require 'rails_helper'
require 'support/factory_girl'

describe Comment do

  let(:user){build(:user)}
  let(:post_comment){build(:post_comment)}

  it "can be added to a post" do
    expect(post_comment.commentable).to be_a(Post)
  end

end