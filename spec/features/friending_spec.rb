require 'rails_helper'

feature "Friendships" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:profile2) {create(:profile)}
  let(:profile3) {create(:profile)}
  let(:user2){ create(:user, profile: profile2) }
  let(:user3){ create(:user, profile: profile3) }
  let(:friendship){ create(:friend, friender: user, friendee: user2) }
  let(:post){ create(:post,user: user3 )}
  let(:post2){ create(:post,user: user2 )}

  before do
    visit root_url
    sign_in(user)
  end

  context "Making Friends" do
    scenario "Adding a friend from their view page" do
      user
      user3
      post
      click_link "Danebook"
      click_link user3.first_name
      click_link "Send Friend Request"
      expect(page).to have_content("Request sent")
    end
  end

  context "Viewing Friends" do
    scenario "Friends page populates when there are friends" do
      user 
      user2 
      post2 
      friendship
      click_link "See More Friends"
      expect(page).to have_content(user2.first_name)
    end

    scenario "Friends page can be reached from nav 2" do
      user 
      user2 
      post2 
      friendship
      visit user_path(user.id)
      click_link "About"
      click_link "Friends"
      expect(page).to have_content(user2.first_name)
    end

    scenario "Clicking a friend from the sidebar takes you to their show page" do
      user 
      user2 
      post2 
      friendship
      visit user_path(user.id)
      click_link "Friends"
      click_link "Timeline"

      click_link user2.first_name

      expect(page).to have_content("Basic Information")
    end
  end



  context "Unmaking Friends" do
    scenario "Removing a friend from their view page" do
      user 
      user2 
      post2 
      friendship
      click_link "Danebook"
      first('.author-box').click_link(user2.first_name)
      click_link "Revoke Friend Request"
      expect(page).to have_content("Request revoked")
    end

    scenario "Removing a friend from their post index" do
      user 
      user2 
      post2 
      friendship
      click_link "Danebook"
      first('.author-box').click_link(user2.first_name)
      click_link "User Timeline"
      click_link "Revoke Friend Request"
      expect(page).to have_content("Request revoked")
    end


    scenario "Removing a friend from the friend view page" do
      user 
      user2 
      post2 
      friendship
      click_link "See More Friends"
      expect(page).to have_content(user2.first_name)
      click_link "Revoke Friendship"
      expect(page).to_not have_content(user2.first_name)
    end
  end
end