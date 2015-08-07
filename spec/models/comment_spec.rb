require 'rails_helper'
require 'support/factory_girl'

describe Comment do

  let(:user){build(:user)}
  let(:post_comment){build(:post_comment)}

  it "can be added to a post" do
    expect(post_comment.commentable).to be_a(Post)
  end

  it "requires a user_id" do
    comment = build(:post_comment, user_id: nil)
    expect(comment).to_not be_valid
  end

  it "requires a commentable id" do
    comment = build(:post_comment, commentable_id: nil,
                    commentable_type: "Post")
    expect(comment).to_not be_valid
  end

  it "can be place on same post by user more than once" do
    comment = build(:post_comment, commentable_id: 1,
                    commentable_type: "Post", user_id: 2)
    comment.save

    new_comment = build(:post_comment, commentable_id: 1,
                    commentable_type: "Post", user_id: 2)

    expect(new_comment).to be_valid
  end

end