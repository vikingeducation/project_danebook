require 'rails_helper'

feature 'Profile Features' do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:user){ create(:user, :profile => profile) }
  
  before {sign_in(user)}

  scenario "clicking on 'About' accesses user profile" do
    click_link("About")
    expect(page).to have_content("Basic Information")
  end

  context 'Using Edit' do

    before do
      click_link("Update Profile")
    end

    scenario "clicking on 'Update Profile' gets to 'Edit Profile' page" do
      expect(page).to have_content("Edit Profile")
    end

    scenario "Edit changes show up on profile page" do
      fill_in "profile[first_name]", with: "Test_Name"
      click_button "Save Changes"
      expect(page).to_not have_content("foo")
      expect(page).to have_content("Test_Name")
    end

    scenario "Entering invalid changes does not update to invalid changes" do
      new_name = "i" * 50
      fill_in "profile[first_name]", with: new_name
      click_button "Save Changes"
      expect(page).to_not have_content(new_name)
      expect(page).to have_content("foo")
    end

  end

end