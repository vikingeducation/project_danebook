require 'rails_helper'

feature 'Update User Profile' do
  let(:user){ create(:profile)}
  context 'logged in' do
    before do
      visit root_path
      log_in(user.user)
      click_link 'Edit Profile'
    end
    scenario 'clicking "edit profile" takes user to edit profile page' do
      expect(page).to have_selector('.edit_user')
    end
    scenario 'can update profile information' do
      fill_in 'Currently lives', with: 'Qwaszx'
      click_button 'Save Changes'
      expect(page).to have_content('Qwaszx')
    end
  end
  context 'logged out'
  scenario 'user cannot see "edit profile" link available' do
    visit user_about_path(user)
    expect(page).not_to have_content 'Edit Your Profile'
  end
end
