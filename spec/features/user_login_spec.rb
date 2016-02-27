require 'rails_helper'

feature 'Log in user' do

  let(:user){create(:user)}

  before do
    sign_in(user)
  end

  scenario 'existing users can sign in with correct login' do
    expect(page).to have_content("You've successfully signed in".upcase)
  end

  scenario 'existing user cannot sign in with wrong login' do
    sign_out
    user.password = 'wrong_password'
    sign_in(user)
    expect(page).to have_content("We couldn't sign you in".upcase)
  end

end