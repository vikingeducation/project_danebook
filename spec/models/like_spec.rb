require 'rails_helper'


describe Like do

  let(:post_like) { build(:post_like) }
  let(:post) { create(:post) }

  let(:comment_like) { build(:comment_like) }
  let(:comment) { create(:comment) }


  it "can't be created without a user_id" do
    expect { create(:post_like, user_id: nil) }.to raise_error(ActiveRecord::RecordInvalid)
  end



  it "can be created on a post" do
    create(:post_like, likeable_id: post.id)
    expect(post.likes.first).to be_instance_of(Like)
  end


  it "can be created on a comment" do
    create(:comment_like, likeable_id: comment.id)
    expect(comment.likes.first).to be_instance_of(Like)
  end


  it "can't create multiple likes on the same post by the same user" do
    post_like.save
    expect { create(:post_like) }.to raise_error(ActiveRecord::RecordInvalid)
  end


  it "can't create multiple likes on the same comment by the same user" do
    comment_like.save
    expect { create(:comment_like) }.to raise_error(ActiveRecord::RecordInvalid)
  end



end