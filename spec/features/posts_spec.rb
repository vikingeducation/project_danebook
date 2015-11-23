require 'rails_helper'

describe 'Post' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:another_user){create(:user, :gender => male)}
  let(:post){create(:post, :user => user, :body => 'Post')}
  let(:post_body){'This is my post body'}

  before do
    visit login_path
    sign_in(user)
  end

  describe 'creation' do
    it 'is enabled only on the current user timeline' do
      visit user_posts_path(another_user)
      expect(page).to_not have_css('#post_body')
    end

    it 'results in the post being added to the timeline' do
      visit user_posts_path(user)
      submit_post(post_body)
      expect(page).to have_content(post_body)
    end
  end

  describe 'deletions' do
    it 'is enabled only on current user posts' do
      create(:post, :user => another_user)
      visit user_posts_path(another_user)
      expect(page).to_not have_content('Delete Post')
    end

    it 'results in the post being removed from the timeline' do
      create(:post, :user => user, :body => post_body)
      visit user_posts_path(user)
      first(:link, :text => 'Delete Post').click
      expect(page).to_not have_content(post_body)
    end
  end
end