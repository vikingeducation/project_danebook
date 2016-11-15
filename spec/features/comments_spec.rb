require 'rails_helper'

describe 'Comments' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:another_user){create(:user, :gender => male)}
  let(:post){create(:post, :user => user, :body => 'Post')}
  let(:comment_body){'Check out the body on this comment!'}
  let(:post_comment){create(:post_comment, :user => user, :commentable => post, :body => comment_body)}

  before do
    post_comment
    visit login_path
    sign_in(user)
  end

  describe 'listing' do
    it 'appears under the post that is commented' do
      visit user_activity_path(user)
      post = find('.post', :text => 'Post')
      expect(post.find('.comment')).to have_content(comment_body)
    end
  end

  describe 'deletion' do
    it 'is only enabled for comments created by the current user' do
      body = 'Another comment'
      create(:post_comment, :user => another_user, :commentable => post, :body => body)
      visit user_activity_path(user)
      expect(find('.comment', :text => body)).to_not have_content('Delete Comment')
    end
  end
end