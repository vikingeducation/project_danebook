require 'rails_helper.rb'

feature "Visitor" do

  let(:user) { create(:user) }
  let(:user_2) { create(:user) }

  before do
    user.create_profile
    user.posts.create(body: "FIRST POST!")
    user_2.create_profile
    user_2.posts.create(body: "secondo posto!")
    visit signup_path
  end

  scenario "can view a user's timeline" do
    visit(user_path(user))
    expect(page).to have_content "See more photos"
    expect(page).to have_content "See more Friends"
  end

  scenario "attempts to access a nonexistant user's timeline" do
    visit(user_path(9999))
    expect(page).to have_content "That User Doesn't Exist!"
    expect(current_path).to eq signup_path
  end

  scenario "can view a user's profile (about)" do
    visit(profile_path(user.id))
    expect(page).to have_content "Basic Information"
    expect(page).to have_content "Contact Information"
    expect(page).to have_content "Words to Live By"
    expect(page).to have_content "About Me"
  end

  scenario "attempts to access a nonexistant user's profile" do
    visit(profile_path(9999))
    expect(page).to have_content "That User Profile Doesn't Exist because the User doesn't have an account here!"
    expect(current_path).to eq signup_path
  end

  scenario "not authorized to edit user profile" do
    visit(edit_profile_path(user))
    expect(page).to have_content "Not authorized! Sign in!"
    expect(current_path).to eq signup_path
  end

  scenario "can view a user's list of friends" do
    visit(friending_path(user))
    expect(current_path).to eq friending_path(user)
  end

  scenario "can sign up for an account" do
    within("#new_user") do
      fill_in "user_first_name", with: "Harry"
      fill_in "user_last_name", with: "Potter"
      fill_in "user_email", with: "harry@potter.com"
      fill_in "user_password", with: "qwerqwer"
      fill_in "user_password_confirmation", with: "qwerqwer"
    end
    expect{ click_on "Sign Up" }.to change(User, :count).by(1)
    expect(page).to have_content "Created a new User!"
    expect(page).to have_content "About"
  end

  scenario "can sign in with a valid account" do
    sign_in(user)
    expect(page).to have_content "You've successfully signed in"
    expect(current_path).to eq user_path user
  end

  scenario "attemps to sign in with invalid credentials" do
    within("#top-navbar") do
      fill_in 'email', with: "poop@poop.com"
      fill_in 'password', with: "poopitypoops"
      click_on 'Login'
    end
    expect(page).to have_content "Wrong username/password combination"
  end

  feature "User" do

    before do
      sign_in(user)
    end

    feature "navbar" do
      scenario "signing in shows personalized navbar" do
        within("#top-navbar") do
          expect(page).to have_content "Signed in as #{user.first_name}"
          expect(page).to have_content "Logout"
        end
      end

      scenario "clicking on Danebook logo takes to timeline page" do
        click_on "Danebook"
        expect(current_path).to eq user_path(user)
      end

      scenario "going to another user's page doesn't change navbar" do
        visit(user_path(user_2))
        within("#top-navbar") do
          expect(page).to have_content "Signed in as #{user.first_name}"
          expect(page).to have_content "Logout"
        end
      end

      scenario "can sign out" do
        within("#top-navbar") do
          click_on "Logout"
        end
        expect(page).to have_content "You've successfully signed out"
        expect(current_path).to eq signup_path
      end
    end

    feature "profile" do
      scenario "edit profile cta appears for user's personal pages" do
        visit(user_path(user))
        expect(page).to have_css(".tl-edit-profile")
        visit(profile_path(user))
        expect(page).to have_css(".tl-edit-profile")
        visit(friending_path(user))
        expect(page).to have_css(".tl-edit-profile")
      end

      scenario "personal profile page also has a Edit Your Profile CTA" do
        visit(profile_path(user))
        expect(page).to have_content "Edit Your Profile"
      end

      scenario "canvas menu Edit Profile CTA links to edit form page" do
        click_on "Edit Profile"
        #expect(page).to have_content "Update Profile"
      end

      scenario "profile Edit Your Profile CTA links to edit form page" do
      end
    end

  end
end
