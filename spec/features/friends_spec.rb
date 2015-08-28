require 'rails_helper'


feature 'Friending other Users' do

  let(:user) { create(:user) }
  let(:potential_friend) { create(:user) }
  let(:current_friend) { create(:user) }
  let(:mutual_friend) { create(:user) }

  before do
    sign_in(user)
    user.friended_users << current_friend
    mutual_friend.friended_users << [user, potential_friend, current_friend]
  end


  context "when on other User's Show page" do

    scenario 'add a User as a Friend' do
      visit user_path(potential_friend)
      click_link 'Friend Me'

      expect(page).to have_content "Added"
      expect(page).to have_link 'Unfriend'
    end


    scenario 'Unfriend a currently-friended User' do
      visit user_path(current_friend)
      click_link 'Unfriend'

      expect(page).to have_content "Unfriended"
      expect(page).to have_link 'Friend Me'
    end

  end


  context 'when on a Friends page' do

    before do
      visit user_friends_path(mutual_friend)
    end


    scenario 'add a User as a Friend' do
      save_and_open_page
      click_link 'Friend Me',
        href: user_friends_path(user, :recipient_id => potential_friend.id)

      expect(page).to have_content 'Added'
      expect(page).to have_link 'Unfriend', href: user_friend_path(user, potential_friend)
    end


    scenario 'Unfriend a currently-friended User' do
      click_link 'Unfriend', href: user_friend_path(user, current_friend)

      expect(page).to have_content 'Unfriended'
      expect(page).to have_link 'Friend Me',
        href: user_friends_path(user, :recipient_id => current_friend.id)
    end

  end


end


