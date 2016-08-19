require 'rails_helper'

feature 'can enter and leave the site' do
  let(:user) { create(:user) }
  let(:profile) { create(:profile) }
  before do
    user.profile = profile
    visit users_path
  end

  scenario 'can signup as a new user' do
    old_user_count = User.count
    signup
    expect(User.count).to eq(old_user_count + 1)
    expect(page).to have_content('User created!')
  end

  scenario 'can login after I have signed up' do
    login(user)
    expect(page).to have_content(user.profile.name)
  end

  scenario 'can logout when i am through danebooking' do
    login(user)
    click_link('Logout')
    expect(page).to_not have_content(user.profile.name)
  end

  scenario 'cannot signup if email is not unique' do
    signup
    user_count = User.count
    signup
    expect(User.count).to eq(user_count)
    expect(page).to have_content('Email has already been taken') # probably should have left this to the model specs
  end

  scenario 'cannot signup if confirmation does not match password' do # probably should have left this to the model specs
    signup({confirmation: 'doesnotmatch'})
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
