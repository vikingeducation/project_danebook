require 'rails_helper'


describe Comment do

  let( :post_comment ) { create( :comment ) }
  let(:post){build(:post)}
  let(:user){build(:user)}

  it "responds to posts assosiation" do
    expect(post_comment).to respond_to(:commentable)
  end

  it "responds to likes assosiation" do
    expect(post_comment).to respond_to(:likes)
  end

  it "responds to user assosiation" do
    expect(post_comment).to respond_to(:user)
  end

  specify "parents respond to their child associations" do
    expect( post_comment.commentable ).to respond_to( :comments )
  end


  it "is invalid when linking with nonexistent author" do
    post_comment.user_id = 123
    expect(post_comment).not_to be_valid
  end

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }


end
