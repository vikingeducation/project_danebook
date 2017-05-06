require 'rails_helper'

feature 'Posting' do
  let(:user){ create(:user, :with_profile) }
  let(:friend){ create(:user, :with_profile)}

  context 'logged in' do
    before do
      visit root_path
      log_in(user)
    end
    scenario 'can post on own timeline' do
      write_post(user)
      expect{ click_button 'Post' }.to change(user.posts, :count).by(1)
    end
    scenario 'successful post refreshes timeline page with latest post' do
      create_post(user)
      expect(page).to have_content('The quick brown fox')
    end
    scenario 'cannot post anothers\' timeline' do
      create_post(friend)
      expect(page).to have_content 'Sorry, you can only post on your own timeline'
    end
  end
  context 'logged out' do
    scenario 'attempt to post redirects user to log in page' do
      create_post(user)
      expect(page).to have_content 'Log in to Danebook'
    end
    scenario 'tells user they can\'t post' do
      create_post(user)
      expect(page).to have_content 'You must log in to continue'
    end
  end
end
