require 'rails_helper'

feature "Editing Profile" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:profile2) {create(:profile)}
  let(:user2){ create(:user, profile: profile2) }
  let(:post){ create(:post,user: user2 )}

  before do
    visit root_url
    sign_in(user)
  end

  context "Editing profile" do

    scenario "Profile can be updated!" do 
      profile
      click_link user.first_name
      click_link "Edit Your Profile"
      fill_in 'profile_college', with: "Unique"
      fill_in 'profile_hometown', with: "Different"
      fill_in 'profile_residence', with: "College"
      fill_in 'profile_telephone', with: "6102222222"
      fill_in 'profile_summary', with: "Eat rocks"
      fill_in 'profile_about_me', with: "Always NVM"
      click_button "Save"
      expect(page).to have_content("Profile Updated!")
    end

    scenario "Profile updates correctly!" do 
      profile
      click_link user.first_name
      click_link "Edit Your Profile"
      fill_in 'profile_college', with: "Unique"
      fill_in 'profile_hometown', with: "Different"
      fill_in 'profile_residence', with: "College"
      fill_in 'profile_telephone', with: "6102222222"
      fill_in 'profile_summary', with: "Eat rocks"
      fill_in 'profile_about_me', with: "Always NVM"
      click_button "Save"
      expect(page).to have_content("Unique")
      expect(page).to have_content("Different")
      expect(page).to have_content("College")
      expect(page).to have_content("6102222222")
      expect(page).to have_content("Eat rocks")
      expect(page).to have_content("Always NVM")
    end
 
 
  end

  context "Browsing Profies" do
    scenario "Can look at other users profiles" do
      user
      user2
      post
      click_link "Danebook"
      click_link user2.first_name
      expect(page).to have_content("Words to Live By")
    end

    scenario "Can look at own profiles" do
      user
      click_link "About"
      expect(page).to have_content("Words to Live By")
    end
  end
end