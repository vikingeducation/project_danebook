require 'rails_helper'

# `feature` is an alias for `describe`
describe "Users" do
  let(:profile){ create(:profile)}
  let(:user){ profile.user }

  feature 'Sign up' do

    before do
      visit root_path
    end

    # `scenario` is an alias for `it`
    context "New user" do
      it "creates a new user" do
        # fill in the form for a new user
        within "form#new_user" do
          fill_in "user_profile_attributes_first_name", with: "Test"
          fill_in "user_profile_attributes_last_name", with: "User"
          fill_in "user_email", with: "foo@bar.com"
          fill_in "user_password", with: "!23456Yuiopasdf"
          fill_in "user_password_confirmation", with: "!23456Yuiopasdf"
          select "2012", from: "user_profile_attributes_birthday_1i"
          select "March", from: "user_profile_attributes_birthday_2i"
          select "13", from: "user_profile_attributes_birthday_3i"
          choose "Male"
        end

        # submit the form and verify it created a user
        expect{ click_button "Sign Up!" }.to change(User, :count).by(1)

        # verify that we've been logged in
        expect(page).to have_css ".profile-username", text: "Test User"

        # verify the flash is working properly
        expect(page).to have_content "Successfully signed up!"
      end

    end

    context "Existing email" do
      it "rejects the attempt and informs the user" do
        user.save
        # fill in the form for a new user
        within "form#new_user" do
          fill_in "user_profile_attributes_first_name", with: "Test"
          fill_in "user_profile_attributes_last_name", with: "User"
          fill_in "user_email", with: user.email
          fill_in "user_password", with: "!23456Yuiopasdf"
          fill_in "user_password_confirmation", with: "!23456Yuiopasdf"
          select "2012", from: "user_profile_attributes_birthday_1i"
          select "March", from: "user_profile_attributes_birthday_2i"
          select "13", from: "user_profile_attributes_birthday_3i"
          choose "Male"
        end

        expect{ click_button "Sign Up!" }.to_not change(User, :count)
        expect(page).to have_content "Email has already been taken"
      end
    end
  end

  feature 'Login' do
    before do
      visit login_path
    end

    context "with improper credentials" do
      before do
        user.email = user.email + "x"
        sign_in(user)
      end

      scenario "does not allow sign in" do
        expect(page).to have_content "Incorrect Credentials"
      end
    end

    context "with proper credentials" do
      before do
        sign_in(user)
      end
      scenario "successfully signs in an existing user" do
        # verify the user nav is shown
        expect(page).to have_css ".profile-username", text: "Hermione Granger"
      end

      context "after signing out" do
        before do
          sign_out
        end
        scenario "the user should be logged out" do
          expect(page).to have_css "div.alert-success p", text: "Signed Out"
        end
      end
    end
  end
end
