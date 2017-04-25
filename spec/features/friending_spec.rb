require 'rails_helper'

feature 'Friending' do
  let(:users){ create_list(:profile, 3)}
  let(:user){ create(:profile).user}
  let(:friend){ create(:profile).user}
  before do
    users
  end
  context 'signed out' do
    scenario 'clicking button to add friend takes user to sign in page' do
      visit user_about_path(User.first)
      click_link 'Add Friend'
      expect(page).to have_content('Connect with all your friends!')
    end
    scenario 'does not have a link to edit profile' do
      visit user_about_path(User.last)
      expect(page).not_to have_content('Edit your profile')
    end
  end
  context 'signed in' do
    before do
      visit root_path
      log_in(user)
    end
    scenario 'has button to add friend if not already friends' do
      friend = create(:profile)
      visit user_profile_path(friend)
      expect(page).to have_content 'Add Friend'
    end
    scenario 'clicking "add friend" button adds user as friend' do
      visit user_about_path(friend)
      expect{ click_link 'Add Friend' }.to change(Friendship, :count).by(1)
      expect(page).to have_content "You and #{friend.first_name} are now friends"
    end
    scenario 'clicking "remove friend" removes user as friend' do
      user.friendees << friend
      visit user_about_path(friend)
      expect{ click_link 'Remove Friend'}.to change(Friendship, :count).by(-1)
    end

  end

end
