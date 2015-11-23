require 'rails_helper'

describe 'Likes' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:post){create(:post, :user => user, :body => 'Post')}
  let(:comment_body){'Check out the body on this comment!'}
  let(:post_comment){create(:post_comment, :user => user, :commentable => post, :body => comment_body)}
  let(:post_like){create(:post_like, :user => user, :likeable => post)}

  before do
    sign_out
    visit login_path
    sign_in(user)
  end

  describe 'creation' do
    it 'is enabled on posts' do
      post 
      visit user_posts_path(user)
      expect(find('.post')).to have_link('Like')
    end

    it 'is enabled on comments' do 
      post_comment
      visit user_posts_path(user)
      expect(find('.comment')).to have_link('Like')
    end

    it 'changes text to Unlike' do 
      post
      visit user_posts_path(user)
      first(:link, :text => 'Like').click
      expect(find('.post')).to have_link('Unlike')
    end
  end

  describe 'deletion' do
    it 'is enabled only on likeables liked by the current user' do 
      post_like
      visit user_posts_path(user)
      first(:link, :text => 'Unlike').click
      expect(find('.post')).to have_link('Like')
    end
  end
end