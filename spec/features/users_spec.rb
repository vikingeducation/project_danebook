require 'rails_helper'

feature 'User accounts' do
  before do
    visit root_path
  end

  scenario "Sign up a new account" do
    fill_in "user_profile_attributes_first_name", with: "Foo"
    fill_in "user_profile_attributes_last_name", with: "Bar"
    fill_in "user_email", with: "foo@bar.com"
    fill_in "user_password", with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"

    expect{ click_button "Sign Up" }.to change(User, :count).by(1)
  end
end