require 'rails_helper'

feature 'Authentication' do
  let(:profile){ create(:profile)}
  let(:user){ create(:user, profile: profile)}
  scenario 'cannot sign in with improper credentials' do
    visit root_path
    user.password = 'xxx'
    log_in(user)
    expect(page).to have_content('Log in to Danebook')
  end
  scenario 'can sign in with proper credentials' do
    visit root_path
    log_in(user)
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'can sign in from another page' do
    user
    visit user_about_path(user)
    log_in(profile.user)
    expect(page).to have_content('Signed in successfully.')
  end
  scenario 'successful sign ins redirects users to their newsfeed' do
    user
    visit root_path
    log_in(profile.user)
    expect(page).to have_selector('.newsfeed-sidebar')
  end

end
