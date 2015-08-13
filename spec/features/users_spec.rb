require 'rails_helper'

feature 'User accounts' do
  before do
    # go to the home page
    visit root_path
  end

  scenario "add a new user" do
    within('.sign-up') do
      fill_in "First Name", with:  "Foo"
      fill_in "Last Name", with:  "Foo"
      
      fill_in "user_email", with: "foo@bar.com"
      fill_in "Password", with: "foobarfoobar"
      fill_in "Confirm Password", with: "foobarfoobar"
    end
    expect{ click_button "Sign-Up" }.to change(User, :count).by(1)

    expect(page).to have_content "Edit Profile"   

  end
end 
