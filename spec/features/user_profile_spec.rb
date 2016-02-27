require 'rails_helper'

include LoginMacros

feature "Users Profile" do

  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit user_path(user)
  end

  #--------------- Happy Path!!! -----------------

  scenario "User should be able to provide more basic information about themselves" do
    click_link "Edit Your Profile"
    #save_and_open_page
    fill_in "profile_college",      with: "All American University"
    fill_in "profile_hometown",     with: "My Town"
    fill_in "profile_current_home", with: "A Town"
    fill_in "profile_mobile",       with: "1234"
    fill_in "profile_summary",      with: "Words words"
    fill_in "profile_about",        with: "More words!"

    expect{click_button "Save Changes"}.to change(Profile, :count).by(0)
    expect(page).to have_content("Profile Updated!")
    expect(page).to have_content("All American University")

  end

  #--------------- Sad Path :( -----------------

    scenario "fields can actually be left blank and the form will still be valid" do
      click_link "Edit Your Profile"
      expect{click_button "Save Changes"}.to change(Profile, :count).by(0)
      expect(page).to have_content("Profile Updated!")
      expect(page).not_to have_content("No college information")
    end

  # ------------------ Bad Path! 😠 *Angry Emoji* ---------------

  # PATHS NO LONGER SUPPORTED
  # context "User cannot make a second profile" do

  #   scenario "After profile has been created I will only be able to modify my profile" do
  #     click_link "Edit Your Profile"
  #     expect(current_path).to eq(new_profile_path)
  #     create(:profile, user_id: user.id)
  #     visit current_path # Refresh the page
  #     expect(current_path).to eq(edit_profile_path)
  #   end

  #   scenario "I will be redirected if I maliciously input the new_profile_path in my browser" do
  #     create(:profile, user_id: user.id)
  #     visit new_profile_path
  #     expect(current_path).to eq(edit_profile_path)
  #   end
  # end

end