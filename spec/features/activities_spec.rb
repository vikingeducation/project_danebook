require 'rails_helper'

describe 'Activities' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:posts){create_list(:post, 2, :user => user)}
  let(:post_comments){create_list(:post_comment, 2, :user => user, :commentable => posts.first)}
  let(:post_like){create(:post_like, :user => user, :likeable => posts.first)}
  let(:comment_like){create(:comment_like, :user => user, :likeable => post_comments.first)}
  let(:profile_photo){create(:profile_photo, :user => user)}
  let(:friend){create(:user, :gender => male)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => friend)}
  let(:post_body){'This is my post body'}

  before do
    visit login_path
    sign_in(user)
    friend_request.accept
    posts
    post_comments
    post_like
    comment_like
  end

  describe 'listing' do
    it 'displays entries for comments' do
      visit news_feed_path
      expect(page).to have_content('commented on')
    end

    it 'displays entries for likes' do
      visit news_feed_path
      expect(page).to have_content("#{user.name} liked #{user.name}'s")
    end

    it 'displays posts' do
      visit news_feed_path
      expect(page).to have_content("#{user.name} posted on")
    end
    
    it 'displays photos' do
      profile_photo
      visit news_feed_path
      expect(page).to have_content("#{user.name} uploaded a new photo")
    end

    it 'displays new friendships' do
      visit news_feed_path
      expect(page).to have_content("#{user.name} became friends with #{friend.name}")
    end

    it 'displays profile updates' do
      visit news_feed_path
      expect(page).to have_content('updated their profile on')
    end
  end

  describe 'posting' do
    it 'submits a post to be added to the activity feed' do
      submit_post(post_body)
      visit news_feed_path
      expect(page).to have_content(post_body)
    end
  end
end