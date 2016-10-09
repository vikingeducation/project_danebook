require 'rails_helper'

feature 'User Features' do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }
  
  before do
    visit root_path
  end

  scenario "add a new user" do
    fill_in "First Name", with: "Montgomery"
    fill_in "Last Name", with: "Burns"
    find(".new-account").fill_in "Email", with: "montyburns@gmail.com"
    fill_in "Your New Password", with: "moneymoney"
    fill_in "Confirm Your Password", with: "moneymoney"

    expect{ click_button "Sign Up!" }.to change(User, :count).by(1)
    expect(page).to have_content "User created."
    expect(page).to have_content "montyburns@gmail.com"
  end

  scenario "sign in to my account" do
    find("#navbar").fill_in "Email", with: user.email
    find("#navbar").fill_in "Password", with: user.password
    click_button("Log In")
    expect(page).to have_content "signed in"
    expect(page).to have_content user.email
  end

  scenario "log out of my account" do
    sign_in(user)
    sign_out
    expect(page).to have_content "signed out"
  end

  scenario "signing up with no attributes results in no entry" do
    click_button "Sign Up!"
    expect(page).to have_content "Connect with all your friends!"
    expect(page).to have_css ".error"
  end

  scenario "signing up with invalid attributes doesn't add user" do
    expect{ click_button "Sign Up!" }.to change(User, :count).by(0)
  end

  scenario "logging in with no attributes results in no entry" do
    click_button "Log In"
    expect(page).to have_content "Login"
    expect(page).to have_content "don't match"
  end

end