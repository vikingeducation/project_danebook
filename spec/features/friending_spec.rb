require 'rails_helper'
require 'pry'

feature 'Friending' do
  let(:users){ create_list(:profile, 3)}
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:friend_invite){ create(:friendship, friender_id: friend.id, friendee_id: user.id)}
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
    scenario 'clicking button to add friend sends a friendship invite' do
      visit user_profile_path(friend)
      click_link 'Add Friend'
      expect(Friendship.last.friend_initiator).to eq(user)
      expect(Friendship.last.friend_recipient).to eq(friend)
      expect(Friendship.last.rejected).to be_nil
    end
    scenario 'can accept a friend request' do
      friend_invite
      visit user_profile_path(friend)
      expect{ click_link 'Accept'}.to change(Friendship, :count).by(1)
    end
    scenario 'clicking "remove friend" removes user as friend'

  end
end
