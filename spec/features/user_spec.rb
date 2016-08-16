require 'rails_helper'

feature 'Users' do
  let!(:user) { create(:user) }

  before do
    visit root_path
  end

  context 'when the user inputs valid login credentials' do

    before do
      visit login_path
      form = find("div#login-form")
      form.fill_in 'session_email', with: user.email
      form.fill_in 'session_password', with: user.password
      form.click_button 'Submit'
    end

    it 'greets them with a success message' do
      expect(page).to have_content('Login successful.')
    end

    it 'shows the user\'s about page' do
      expect(page).to have_content('About')
    end
    
  end

  context 'when the user inputs invalid login credentials' do

    before do
      visit login_path
      form = find("div#login-form")
      form.fill_in 'session_email', with: "random@email.com"
      form.fill_in 'session_password', with: "z"
      form.click_button 'Submit'
    end

    it 'greets them with a failure message' do
      expect(page).to have_content('Invalid username/password.')
    end

    it 're-enders the login page' do
      expect(page).to have_content('Log in')
    end

  end

  context 'when an unauthorized user attempts to visit a page' do

    before do
      visit login_path
      form = find("div#login-form")
      form.fill_in 'session_email', with: user.email
      form.fill_in 'session_password', with: user.password
      form.click_button 'Submit'
    end

    describe "trying to edit another user's profile" do
      it 'greets them with a failure message' do
        other_user = create(:user)
        visit edit_user_path(other_user)
        expect(page).to have_content('You are not authorized to access that page.')
      end
    end

    describe "trying to delete another user's profile" do
      it 'greets them with a failure message' do
        other_user = create(:user)
        page.driver.submit :delete, user_path(other_user), {}
        expect(page).to have_content('You are not authorized to access that page.')
      end
    end

  end

end