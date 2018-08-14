require 'rails_helper'
include LoginMacros

RSpec.feature 'UserInteractions' do

  let(:user) { create(:user, id: 1) }
  let(:profile) { create(:profile, user_id: 1) }
  let(:second_user) { create(:user, id: 2) }
  let(:second_profile) { create(:profile, user_id: 2)}

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
      comment = "This is my comment, read it and weap"
      visit '/users/2/timeline'
      fill_in "comment_body", with: comment
      click_button "Comment"
      expect(page).to have_content comment
    end

    scenario "I want to like/unlik an interesting post" do
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

    scenario "I want to like/unlik an interesting comment" do
      sign_in(user)
      new_post = create(:post, user_id: 2)
      new_comment = create(:comment, user_id: 2, post_id: new_post.id)
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

    scenario "I want to post a message on my friends timeline" do
      sign_in(user)
      visit '/users/2/timeline'
      fill_in "post_body", with: "Hello Friend"
      expect(page).to have_content "Hello Friend"
      expect(page).to have_content "#{second_user.profile.name}"
    end

    scenario "I try to edit someone else's profile" do
      sign_in(user)
      visit '/users/2/profile'
      click_link "Edit Your Profile"
      expect(page).to have_content "Edit About"
      expect(page).to have_content "#{user.profile.name}"
    end

    scenario "When editing my profile I try to save without a valid attribute" do
      sign_in(user)
      click_link "Edit Profile"
      fill_in "Email", with: ""
      click_button "Update Information"
      expect(page).to have_content "Edit About"
      expect(page).to have_content "#{user.profile.name}"
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
