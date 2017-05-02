require 'rails_helper'

feature 'Adding Photos' do
  let(:user){ create(:user, :with_profile)}
  context 'Logged in' do
    before do
      visit root_path
      log_in(user)
    end
    scenario 'Clicking \'Add Photos\' leads to photo upload page' do
      visit user_photos_path(user)
      click_link 'Add Photos'
      expect(page).to have_button('Upload Photo')
      expect(page).to have_button('Use Web Photo')
    end
    scenario 'Can only add photos to own account' do
      visit user_photos_path(create(:user, :with_profile))
      expect{ click_button 'Add Photo' }.to raise_error(Capybara::ElementNotFound)
    end

  end
end
