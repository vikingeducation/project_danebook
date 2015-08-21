require 'rails_helper'

describe Post do

  context 'associations' do
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

end