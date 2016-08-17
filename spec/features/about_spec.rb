require 'rails_helper'

feature "Profile" do
  let(:profile) { create(:profile) }
  let(:user) { create(:user, profile: profile) }

  before do
    sign_in(user)
    visit user_profile_path(user)
  end

  context "viewing about page" do

    scenario "should see user info" do
      expect(page).to have_content(user.email)
      expect(page).to have_content(user)
    end

    scenario "should see profile info" do
      expect(page).to have_content(profile.birthday.strftime("%x"))
      expect(page).to have_content(profile.about)
    end

  context "editing about page" do
    before { click_link "Edit Profile" }

    context "with valid changes" do
      let(:altered_profile) { build(:profile, about: "Altered about!", birthday: 100.years.ago)}

      scenario "should be able to edit page" do
        fill_about_form(altered_profile)
        expect(page).to have_content(altered_profile.about)
        expect(page).to have_content(altered_profile.birthday.strftime("%x"))
      end

      context "with invalid changes" do
        let(:invalid_profile) { build(:profile, first_name: "")}
        scenario "shouldn't change about page" do
          fill_about_form(invalid_profile)
          expect(page).to have_selector ".alert-error"
          expect(page).to have_content(profile.birthday.strftime("%x"))
        end
      end

    end


  end

end


end
