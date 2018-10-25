require 'rails_helper'
include LoginMacros

RSpec.feature 'UserInteractions' do

  let(:user) { create(:user, id: 1) }
  let(:profile) { create(:profile, user_id: 1) }
  let(:second_user) { create(:user, id: 2) }
  let(:second_profile) { create(:profile, user_id: 2)}
  let(:users){ create_list(:profile, 3, first_name: "Zachariah")}

  before do
    user
    profile
    second_user
    second_profile
    visit root_path
  end

  feature 'Signed-in User' do

    scenario "I want to see my timeline" do
      sign_in(user)
      click_link "Timeline"
      expect(page).to have_content "#{user.profile.name}"
    end

    scenario "I want to post on my timeline" do
      post = "This is my new post!!!"
      sign_in(user)
      click_link "Timeline"
      fill_in "post_body", with: post
      click_button "Submit"
      expect(page).to have_content post
    end

    scenario "I want to comment on my friends post" do
      sign_in(user)
      new_post = create(:post, user_id: 2)
      new_comment = "This is my comment, read it and weap"
      visit '/users/2/timeline'
      fill_in "comment_body", with: new_comment
      click_button "Comment"
      expect(page).to have_content new_comment
    end

    scenario "I want to like/unlike an interesting post" do
      sign_in(user)
      new_post = create(:post, user_id: 2)
      visit '/users/2/timeline'
      click_link "like"
      expect(page).to have_link "unlike"
      expect(current_path).to eq('/users/2/timeline')
      click_link "unlike"
      expect(page).to have_link "like"
      expect(current_path).to eq('/users/2/timeline')
    end

    scenario "I want to like/unlike an interesting comment" do
      sign_in(user)
      new_post = create(:post, user_id: 2)
      new_comment = create(:comment, user_id: 2, commentable_id: new_post.id, commentable_type: 'Post')
      visit '/users/2/timeline'
      within(".inner-comment-body") do
        click_link "like"
      end
      expect(page).to have_link "unlike"
      expect(current_path).to eq('/users/2/timeline')
      click_link "unlike"
      expect(page).to have_link "like"
      expect(current_path).to eq('/users/2/timeline')
    end

    scenario "I want to see my profile" do
      sign_in(user)
      click_link "About"
      expect(page).to have_content "Basic Information"
      expect(page).to have_content "#{user.email}"
    end

    scenario "I want to edit my profile" do
      sign_in(user)
      click_link "Edit Profile"
      expect(page).to have_content "Edit About"
      expect(page).to have_button "Update Information"
    end

    scenario "I want to see my friends profile" do
      sign_in(user)
      visit '/users/2/timeline'
      click_link "About"
      expect(page).to have_content "Basic Information"
      expect(page).to have_content "#{second_user.email}"
    end

    scenario "I try to edit someone else's profile" do
      sign_in(user)
      visit '/users/2/profile'
      click_link "Edit Profile"
      expect(page).to have_content "About"
      expect(page).to have_content "#{second_user.profile.name}"
      expect(page).to have_content "Sorry - you may not edit another user's profile"
    end

    scenario "When editing my profile I try to save without a valid attribute" do
      sign_in(user)
      click_link "Edit Profile"
      fill_in "Email", with: ""
      click_button "Update Information"
      expect(page).to have_content "Edit About"
      expect(page).to have_content "#{user.profile.name}"
    end

    scenario "I want to be able to search for more friends by first name" do
      sign_in(user)
      fill_in "Search for Users", with: "#{second_user.profile.first_name}"
      click_button "Search"
      expect(page).to have_content "Search Results"
      expect(page).to have_content "#{second_user.profile.name}"
    end

    scenario "I want to be able to search for more friends by last name" do
      sign_in(user)
      fill_in "Search for Users", with: "#{second_user.profile.last_name}"
      click_button "Search"
      expect(page).to have_content "Search Results"
      expect(page).to have_content "#{second_user.profile.name}"
    end

    scenario "Searching for friends with one letter brings up all users with names containing that letter" do
      users
      sign_in(user)
      fill_in "Search for Users", with: "Z"
      click_button "Search"
      expect(page).to have_content "Search Results"
      expect(page).to have_content "Zachariah"
      expect(page).to_not have_content "#{second_user.profile.name}"
    end

  end

  feature 'Not Signed-in User' do

    scenario "I want to sign-in to my account and land on my timeline" do
      visit root_path
      fill_in "email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      expect(page).to have_content "#{user.profile.name}"
      expect(page).to have_content "Post"
    end

    scenario "I mistype password or email" do
      visit root_path
      fill_in "email", with: user.email
      fill_in "Password", with: "lkajfoidjs"
      click_button "Log In"
      expect(page).to have_content "Unable to sign in"
    end

  end
end
