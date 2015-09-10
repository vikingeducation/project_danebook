require 'rails_helper'

feature 'signing in' do
  before do
    visit root_path
  end

  scenario 'the root path should be the signup/signin screen' do
    expect(page).to have_css("form#new_user")
  end

  context 'signing in with information' do

    scenario 'should be able to sign in with proper information' do
      login_user

      expect(page).to_not have_css('div.error')
      expect(current_url).to eq(user_posts_url(User.first, newsfeed: "true"))
      expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to_not be_nil
    end

    scenario 'should not be able to sign in without registered email' do
      login_user(email: "sldkfjsdlfkj")

      expect(page).to have_css('div.error')
      expect(current_url).to_not eq(user_url(User.first))
      expect(current_url).to eq(new_user_url)
      expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
    end

    scenario 'should not be able to sign in with wrong password' do
      login_user(password: "sldkfjslekfjseklj")

      expect(page).to have_css('div.error')
      expect(current_url).to_not eq(user_url(User.first))
      expect(current_url).to eq(new_user_url)
      expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
    end

    scenario 'should not stay logged in if remember me box is not checked' do
      login_user
      delete_temporary_cookies
      visit root_path
      expect(current_url).to eq(root_url)
    end

    scenario 'should stay logged in if remember me box is not checked' do
      login_user(remember_me: true)
      delete_temporary_cookies
      visit root_path
      expect(current_url).to eq(user_url(User.first))
    end
  end

  context 'signing out' do

    scenario 'should be able to sign out from user page' do
      login_user
      click_button "dropdownMenu1"
      click_link("Sign Out", match: :first)
      expect(current_url).to eq(new_user_url)
      expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
    end

  end
end
