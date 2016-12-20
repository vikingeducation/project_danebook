require 'rails_helper'

feature 'User accounts' do

  let(:profile1) { create(:profile) }
  let(:user1) { profile1.user }
  let(:post1) { user1.post}
  let(:profile2) { create(:profile) }
  let(:user2) { profile2.user }
  let(:post2) { user2.post}
  let(:profile3) { create(:profile) }
  let(:user3) { profile3.user }
  let(:post3) { user3.post}

  before do
    # go to the home page
    visit root_path
  end

  scenario "Create user" do
    within "#new_user" do
      fill_in "user_first_name", with: "Testy"
      fill_in "user_last_name", with: "McTestface"
      fill_in "user_email", with: "testy@testface.com"
      fill_in "user_password", with: "testing123"
      fill_in "user_password_confirmation", with: "testing123"
      select "1986", from: "user_profile_attributes_birthday_1i"
      select "June", from: "user_profile_attributes_birthday_2i"
      select "7", from: "user_profile_attributes_birthday_3i"
      choose "Other"
      click_button "Sign Up"
    end
    expect(page).to have_css(".alert.alert-success", text: "Welcome")
    expect(User.find_by_email('testy@testface.com').profile.birthday).to eq(Date.parse("Sat, 07 Jun 1986"))
  end

  scenario "Add a friend" do
    log_in(user1)
    visit user_profile_path(user2)
    click_button "Add user as friend"
    expect(page).to have_content "#{user2.name} is now your friend"
  end

  scenario "Remove a friend" do
    log_in(user1)
    visit user_profile_path(user2)
    click_button "Add user as friend"
    click_button "Remove friend"
    expect(page).to have_content "No longer friends with #{user2.name}"
  end

  scenario "See posts by friends" do
    log_in(user2)
    click_link "Timeline"
    fill_in "post_body", with: "Post from user2"
    click_button('Post')

    log_in(user1)
    click_link "Timeline"
    fill_in "post_body", with: "Post from user1"
    click_button('Post')
    visit user_profile_path(user2)
    click_button "Add user as friend"
    visit user_friends_path(user1)
    within ".newsfeed" do
      expect(page).to have_content "Post from user2"
      expect(page).to have_content "Post from user1"
      expect(page).not_to have_content user3.name
    end
  end

end
