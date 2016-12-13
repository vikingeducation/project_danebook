require 'rails_helper'

describe Post do

  let(:post) { build(:post) }

  describe '#total_likes' do

    let(:num_likes) { 4 }

    before do
      post.likes = create_list(:like, num_likes)
      post.save
    end

    it 'counts up the total number of likes on a post' do
      expect(post.total_likes).to eq(num_likes)
    end

  end

  # describe '#reversed' do

  #   it 'returns the posts in reverse order' do
  #     posts = create_list(:post, 5)
  #     reversed_posts = Post.reversed
  #     reversed = true

      

  #     expect(reversed).to be true

  #   end

  # end


end