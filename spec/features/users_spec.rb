require 'rails_helper'

feature 'User accounts' do
  before do
    visit root_path
  end
  let!(:user) { create(:user) }

  scenario "Successfully sign up a new account and go to profile edit page" do
    fill_in "user_profile_attributes_first_name", with: "Foo"
    fill_in "user_profile_attributes_last_name", with: "Bar"
    fill_in "user_email", with: "foo@bar.com"
    fill_in "user_password", with: "foobar"
    fill_in "user_password_confirmation", with: "foobar"

    expect{ click_button "Sign Up" }.to change(User, :count).by(1)

    expect(User.last.profile).not_to be_nil
    expect(User.last.profile.full_name).to eq("Foo Bar")
    expect(page).to have_content("Edit Your Profile")
  end

  context "Fail to sign up a new account and stay on signup page" do
    scenario "without a password" do
      fill_in "user_profile_attributes_first_name", with: "Foo"
      fill_in "user_profile_attributes_last_name", with: "Bar"
      fill_in "user_email", with: "foo@bar.com"
      fill_in "user_password_confirmation", with: "foobar"

      expect{ click_button "Sign Up" }.to change(User, :count).by(0)

      expect(User.last.email).not_to eq("foo@bar.com")
      expect(User.last.profile.full_name).not_to eq("Foo Bar")
      expect(page).to have_button("Sign In")
      expect(page).to have_button("Sign Up")
    end
  end

  scenario "Sign in to an existing account and go to user's timeline page" do
    profile = user.create_profile( attributes_for(:profile) )
    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_button "Sign In"
    
    expect(page).to have_content("About Me")
    expect(page).to have_content("#{profile.full_name}")
    expect(page).to have_button("Post")
  end

  context "Fail to sign in to an existing account and stay on signup page" do
    scenario "with a non-exsiting email" do
      fill_in "email", with: "someone@somecom"
      fill_in "password", with: user.password

      click_button "Sign In"

      expect(page).to have_button("Sign In")
      expect(page).to have_button("Sign Up")
    end
  end
end