require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:user) { build(:user) }
  let(:post) { build(:post) }

  it "is valid with default attributes" do
    expect(post).to be_valid
  end

  it "has likes" do
    expect(post).to respond_to(:likes)
  end

  it "can be liked" do
    a = build(:post)
    a.save
    u = build(:user)
    u.save
    a.likes.create(user_id: u.id)
    expect(a.likes.map { |like| like.user_id }).to include(u.id)
  end

  it "can be un-liked" do
    my_post = build(:post)
    my_post.save
    my_post_id = my_post.id
    my_user = build(:user)
    my_user.save
    my_user_id = my_user.id
    my_post.likes.create(user_id: my_user_id)
    my_like = my_post.likes.find_by_user_id(my_user_id)
    my_like.destroy
    expect(Post.find_by_id(my_post_id).likes.map { |like| like.user_id }).not_to include(my_user_id)
  end

  it "can't be liked more than once" do
    my_post = build(:post)
    my_post.save
    my_post_id = my_post.id
    my_user = build(:user)
    my_user.save
    my_user_id = my_user.id
    my_post.likes.create(user_id: my_user_id)
    my_post.likes.create(user_id: my_user_id)

    expect(Post.find_by_id(my_post_id).likes.map { |like| like.user_id }).to eq([my_user_id])
    expect(Post.find_by_id(my_post_id).likes.map { |like| like.user_id }).not_to eq([my_user_id, my_user_id])
  end

  it "can list the ids of people who like it" do
    bob = build(:user)
    bob.save
    larry = build(:user)
    larry.save
    my_post = build(:post)
    my_post.save
    my_post.likes.create(user_id: bob.id)
    my_post.likes.create(user_id: larry.id)
    expect(my_post.likes.map { |like| like.user_id }).to match_array([bob.id, larry.id])
  end

end
