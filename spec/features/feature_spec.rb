require 'rails_helper'

feature 'Danebook App' do

  let(:user) { build(:user) }
  let(:profile) { build(:profile) }

  let(:created_profile) { create(:profile) }
  let(:created_user) { created_profile.user }

  let(:other_profile) { create(:profile) }
  let(:other_user) { created_profile.user }


  context "when signed out" do

    scenario 'it redirects user to sign up page when trying to view any other page' do
      visit user_posts_path(created_user)
      expect(page).to have_current_path(login_path)
    end

    scenario 'it signs up a user with appropriate credentials' do
      sign_up_user(user, profile)
      expect(page).to have_content "Welcome #{user.email}"
    end

    scenario 'it allows a user to log in with appropriate credentials' do
      log_in_user(created_user)
      expect(page).to have_content "Welcome #{created_user.email}"
    end

  end

  context "when signed in" do

    before do
      log_in_user(created_user)
    end

    context "on user's own account" do

      scenario 'it redirects to about page when navigating to root' do
        visit('/')
        expect(page).to have_current_path(user_path(created_user))
      end

      scenario 'it allows user to update information' do
        click_on('Edit Profile')
        fill_in 'College', with: 'MIT'
        click_on('Save Changes')
        expect(page).to have_content('Profile successfully updated')
      end

      scenario 'it allows user to post on his account' do
        click_on('Timeline')
        within ("main.container") do
          fill_in 'post_content', with: 'This is my post'
          click_on 'Post'
        end
        expect(page).to have_content('This is my post')
      end

      scenario 'it allows user to delete his posts' do
        click_on('Timeline')
        fill_in 'post_content', with: 'This is my post'
        click_on 'Post'
        click_link 'Delete'
        expect(page).to have_content('Post deleted')
      end

    end

    context "on other users' pages" do

      before do
        visit user_path(other_user)
      end

      scenario 'it allows user to view other users\' about and timeline pages' do
        expect(page).to have_content(other_user.full_name)
      end

      scenario 'it does not allow user to view other users\' edit pages' do
        expect(page).to_not have_content "Edit Profile"
      end

      scenario 'it does not allow user to post on other users\' timelines'

      scenario 'it allows user to comment on other users\' posts'

      scenario 'it does not allow user to delete other users\' posts'     

    end

  end

end