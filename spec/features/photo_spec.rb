require 'rails_helper'

feature 'Adding Photos' do
  let(:user){ create(:user, :with_profile)}
  context 'Logged in' do
    before do
      visit root_path
      log_in(user)
    end
    scenario 'Clicking \'Add Photo\' leads to photo upload page' do
      visit user_photos_path(user)
      click_button 'Add Photo'
      expect(page).to redirect_to user_photo_upload_path(user)
    end
    scenario 'Can only add photos to own profile' do
      visit user_photos_path(create(:user, :with_profile))
      expect{ click_button 'Add Photo' }.to raise_error(Capybara::ElementNotFound)
    end

  end
end
