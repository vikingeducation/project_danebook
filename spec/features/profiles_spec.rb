require 'rails_helper'

describe "Profiles" do
  let(:profile){ create(:profile)}
  let(:second_profile){ create(:profile, first_name: "Ron", last_name: "Weasley")}
  let(:user){ profile.user }
  let(:second_user){ second_profile.user }



  feature "View Profile" do

    context "Authenticated" do

      before do
        profile
        sign_in(user)
        visit root_path
        click_link "About"
      end

      it "renders the about page" do
        expect(page).to have_current_path(user_profile_path(user))
        expect(page).to have_css "section#about"
      end

      context "Current User" do
        it "shows the edit profile link" do
          expect(page).to have_css "li.edit > a", text: "Edit Profile"
          expect(page).to have_link "Edit Profile"
        end
      end

      context "Other User" do
        it "does not show the edit profile link" do
          second_profile.save
          visit user_profile_path(second_user)
          expect(page).to have_css ".profile-username", text: "#{second_profile.first_name} #{second_profile.last_name}"
          expect(page).to_not have_css "li.edit > a"
        end
      end

    end
    context "Unauthenticated User" do
      it "redirects to login path" do
        visit user_profile_path(user)
        expect(page).to have_current_path(login_path)
      end
    end
  end

  feature "Edit Profile" do

    context "Authenticated" do

      before do
        profile
        sign_in(user)
        visit root_path
        click_link "Edit Profile"
      end

      it "renders the Edit-About page" do
        expect(page).to have_current_path(edit_user_profile_path(user))
        expect(page).to have_css "section#about-edit"
      end

      context "Current User" do
        it "shows the edit profile form" do
          expect(page).to have_css "form#edit_profile_#{user.profile.id}"
        end

        it "can update the current user's info" do
          expect(page).to have_css "select#profile_birthday_1i"
          expect(page).to have_css "form#edit_profile_#{user.profile.id}"
          new_date = 10.years.ago
          within "form#edit_profile_#{user.profile.id}" do
            fill_in "profile_college", with: "New College"
            fill_in "profile_hometown", with: "New Hometown"
            fill_in "profile_current_home", with: "New Current"
            fill_in "profile_phone", with: "555-555-5555"
            select new_date.year, from: "profile_birthday_1i"
            select new_date.strftime('%B'), from: "profile_birthday_2i"
            select new_date.day, from: "profile_birthday_3i"
            click_button "Save Changes"
          end

          profile.reload
          expect(profile.college).to eq("New College")
          expect(profile.hometown).to eq("New Hometown")
          expect(profile.birthday).to eq(new_date.to_date)
        end

        it "creates a bio if a slogan is filled out for the first time" do
          fill_in "profile_bio_attributes_slogan", with: "Words Words Words"
          expect{click_button "Save Changes"}.to change(Bio, :count).by(1)
        end

        it "creates a bio if the About Me section is filled out for the first time" do
          fill_in "profile_bio_attributes_about", with: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco"
          expect{click_button "Save Changes"}.to change(Bio, :count).by(1)
        end

        it "Updates an existing bio" do
          bio = create(:bio, profile: profile)
          slogan = bio.slogan

          visit edit_user_profile_path(user)

          fill_in "profile_bio_attributes_slogan", with: "#{slogan} Words"

          expect{click_button "Save Changes"}.to_not change(Bio, :count)
          expect(bio.slogan).to_not eq("#{slogan} Words")
        end

      end

      context "Other User" do
        it "does not allow editing other user profiles" do
          visit edit_user_profile_path(second_user)
          expect(page).to_not have_current_path(edit_user_profile_path(second_user))
        end

        it "redirects back to the logged in user's profile" do
          visit edit_user_profile_path(second_user)
          expect(page).to have_current_path(user_profile_path(user))
        end
      end
    end

    context "Unauthenticated User" do
      it "redirects to the login path" do
        visit edit_user_profile_path(second_user)
        expect(page).to have_current_path(login_path)
      end
    end
  end

end
