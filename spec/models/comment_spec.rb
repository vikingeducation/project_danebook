require 'rails_helper'

describe Comment do

  let(:user){create(:user)}
  let(:post){user.posts_written.create(attributes_for(:post))}
  let(:comment){user.comments_written.build(attributes_for(:comment, commentable_id: post.id) )}

  it "should be valid with valid attributes" do
    expect(comment).to be_valid
  end

  it { should belong_to(:user)}

  it { should belong_to(:commentable)}

  it { should have_many(:comments)}

  it { should have_many(:likes)}




end