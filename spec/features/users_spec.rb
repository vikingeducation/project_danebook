require 'rails_helper'

feature 'Signing Up' do

  before do
    visit root_path
  end

  scenario "adds a new user" do
    sign_up("foo@bar.com")
    expect{ click_button "Sign Up!" }.to change(User, :count).by(1)
    expect(page).to have_css(".alert-success")
  end

  scenario "user can't be created with same email address" do
    sign_up("foo@bar.com")
    click_button("Sign Up!")
    click_link("Logout")
    sign_up("foo@bar.com")
    click_button("Sign Up!")
    expect(page).to have_css(".alert-danger")
    expect(page).to have_content "has already been taken"
  end

end

feature 'Logging in and out' do

  let(:profile) {create(:profile)}
  let(:user){ create(:user, :profile => profile )}
  before do
    user
    visit root_path
  end

  scenario "user can log in with valid credentials" do
    sign_in(user)
    expect(page).to have_css(".alert-success")
  end


  scenario "user can log out" do
    sign_up("foo@bar.com")
    click_button("Sign Up!")
    click_link("Logout")
    expect(page).to have_css(".alert-success")
  end





end