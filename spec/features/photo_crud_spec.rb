require 'rails_helper'

feature 'User photo CRUD' do

  let(:user){create(:user)}
  let(:other_user){create(:user)}


  scenario 'redirects to sign in page when user not logged in' do
    visit user_posts_path(user.id)
    expect(page).to have_content("NOT AUTHORIZED, PLEASE SIGN IN!")
  end

  context 'upload and display photo' do

    before do
      sign_in(user)
      visit user_posts_path(user.id)
    end

    scenario "can upload to his/her photos" do
      expect(page).to have_content("Add Photo")
    end
  end
end