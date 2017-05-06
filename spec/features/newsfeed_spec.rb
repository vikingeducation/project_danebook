require 'rails_helper'

feature 'Newsfeed Browsing' do
  let(:user){ create(:user, :with_profile)}
  context 'logged out' do
    it 'shows the log in page' do
      visit root_path
      expect(page).to have_text('Connect with')
    end
  end
  context 'logged in' do
    before do
      visit root_path
      log_in(user)
    end
    it 'shows the newsfeed' do
      expect(page).to have_selector('.newsfeed-sidebar')
    end
    it 'posting to newsfeed reloads page on success' do
      within ('.post-form') do
        fill_in 'post[body]', with: :'The quick brown fox'
        click_button 'Post'
      end
      expect(page).to have_text('The quick brown fox')
      expect(page).to have_selector('.newsfeed-sidebar')
    end
  end

end
