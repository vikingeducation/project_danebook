require 'rails_helper'

feature 'Friending' do
  let(:users){ create_list(:user, 3, :with_profile)}
  let(:user){ create(:user, :with_profile)}
  let(:friend){ create(:user, :with_profile)}
  let(:friend_invite){ create(:friendship, friender_id: friend.id, friendee_id: user.id)}
  context 'signed out' do
    before do
      users
    end
    scenario 'cannot add friend' do
      visit user_about_path(users.first)
      click_link 'Add Friend'
      expect(page).to have_content('Connect with all your friends!')
    end
  end
  context 'signed in' do
    before do
      visit root_path
      log_in(user)
    end
    scenario 'can send a friend invite' do
      visit user_profile_path(friend)
      click_link 'Add Friend'
      expect(Friendship.last.friend_initiator).to eq(user)
      expect(Friendship.last.friend_recipient).to eq(friend)
      expect(Friendship.last.rejected).to be_nil
    end
    scenario 'can accept friend requests' do
      friend_invite
      visit user_profile_path(friend)
      expect{ click_link 'Accept'}.to change(Friendship, :count).by(1)
    end
    scenario 'can remove friends' do
      create(:friendship, friender_id: user.id, friendee_id: friend.id, rejected: false)
      create(:friendship, friender_id: friend.id, friendee_id: user.id, rejected: false)
      visit user_profile_path(friend)
      expect{ click_link 'Remove Friend'}.to change(Friendship, :count).by(-2)
    end

  end
end
