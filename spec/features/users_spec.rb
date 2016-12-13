require 'rails_helper'

feature 'User accounts' do
  before do
    # go to the home page
    visit root_path
  end

  scenario "Create user" do
    within "#new_user" do
      fill_in "user_first_name", with: "Testy"
      fill_in "user_last_name", with: "McTestface"
      fill_in "user_email", with: "testy@testface.com"
      fill_in "user_password", with: "testing123"
      fill_in "user_password_confirmation", with: "testing123"
      select "1986", from: "user_profile_attributes_birthday_1i"
      select "June", from: "user_profile_attributes_birthday_2i"
      select "7", from: "user_profile_attributes_birthday_3i"
      choose "Other"
      click_button "Sign Up"
    end
    expect(page).to have_css(".alert.alert-success", text: "Welcome")
  end

end
