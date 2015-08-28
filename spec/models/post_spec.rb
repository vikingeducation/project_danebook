require 'rails_helper'

describe Post do

  describe 'table structure' do
    it { should have_db_column(:poster_id) }
  end

  context 'associations' do
    it { should belong_to(:poster) }
    it { should have_many(:comments).dependent(:destroy) }
  end


  context 'when deleting a post' do

    let(:post) { create(:post) }
    let(:comment) { build(:comment, :on_post) }
    let(:like) { build(:post_like) }

    before do
      post.comments << comment
      post.likes << like
      post.destroy
    end

    it 'should delete dependent Comments with no orphans' do
      expect_destroyed_orphan(comment)
    end

    it 'should delete dependent Likes with no orphans' do
      expect_destroyed_orphan(like)
    end

  end


  describe '#get_newsfeed' do

    before do
    end


    it 'gets posts by friends' do
      create_list(:post, 8)
      friend_ids = Post.pluck(:poster_id)

      # create a dummy post that shouldn't be pulled
      create(:post)

      results = Post.get_newsfeed(friend_ids)
      expect(results.size).to eq(8)
    end


    it 'orders posts by date descending' do
      early_post = create(:post, :created_at => 2.days.ago)
      later_post = create(:post, :created_at => 1.day.ago)

      friend_ids = Post.pluck(:poster_id)
      results = Post.get_newsfeed(friend_ids)

      expect(results.first).to eq(later_post)
      expect(results.last).to eq(early_post)
    end


    it 'limits number of posts to 10' do
      create_list(:post, 11)
      friend_ids = Post.pluck(:poster_id)

      results = Post.get_newsfeed(friend_ids)
      expect(results.size).to eq(10)
    end


    it 'limits posts to within the last 7 days' do
      create(:post, :created_at => 1.day.ago)
      old_post = create(:post, :created_at => 8.days.ago)

      friend_ids = Post.pluck(:poster_id)
      results = Post.get_newsfeed(friend_ids)

      expect(results.pluck(:id)).not_to include(old_post.id)
    end

  end

end