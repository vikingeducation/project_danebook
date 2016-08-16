require 'rails_helper'

feature 'Users' do
  let!(:user) { create(:user) }

  before do
    visit root_path
  end

  context 'when the user inputs valid login credentials' do

    # before do
    #   within("div#sign-in-form") do
        # fill_in 'session_email', with: user.email
        # fill_in 'session_password', with: user.password
        # click_button 'Submit'
    #   end
    # end

    before do
      visit login_path
      find("div#login-form").fill_in 'session_email', with: user.email
      find("div#login-form").fill_in 'session_password', with: user.password
      find("div#login-form").click_button 'Submit'
    end

    it 'greets them with a success message'

    it 'shows the user\'s about page' do
      expect(page).to have_content('About')
    end
    
  end

  context 'when the user inputs invalid login credentials'

  context 'when an unauthorized user attempts to visit a page'

end