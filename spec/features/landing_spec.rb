require 'rails_helper'

feature "Login" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }

  before do
    visit root_url
  end

  context "not logged in" do


    scenario "Arrive at landing page" do
      expect(page).to have_content("Sign Up")
    end

    scenario "logging in with valid data works" do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(page).to have_content("You've successfully signed in") 
    end
   
    scenario "make a valid account works" do 
      fill_in 'firstName', with: "Blah"
      fill_in 'lastName', with: "Good"
      fill_in 'inputEmail', with: "example@example.com"
      fill_in "Your Password", with: "password"
      fill_in "Confirm Password", with: "password"
      choose("female")
      fill_in 'user_profile_attributes_birthday', with: "10-20-1920"
      click_button 'Sign Up!'
      expect(page).to have_content("Welcome to Danebook!")
    end

    scenario "make an invalid account fails" do 
      fill_in 'firstName', with: "Blah"
      fill_in 'lastName', with: "Good"
      fill_in 'inputEmail', with: "example@example.com"
      fill_in "Your Password", with: "password"
      fill_in "Confirm Password", with: "passfdsafadsword"
      choose("female")
      fill_in 'user_profile_attributes_birthday', with: "10-20-1920"
      click_button 'Sign Up!'
      expect(page).to have_content("Something went wrong!")
    end

    scenario "logging in with invalid data fails" do
      fill_in 'email', with: "gogiogiogigogi"
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(page).to have_content("We couldn't sign you in")
    end

    scenario "tries to visit a page that is not allowed, and gets rejected" do 
      visit user_path(id: 1, method: :delete)
      expect(page).to have_content("Please sign in or sign up to see this page!")
    end
 
  end

  context "logged in user" do 
    scenario "attempt to go to the account new page and fail" do
      sign_in(user)
      visit new_user_path
      expect(page).to have_content("You already have an account!")
    end

    context 'Visiting a page' do
      #i apparently need selenuim?
      it 'should not have JavaScript errors', :js => true do
        sign_in(user) 
        visit root_path
        expect(page).not_to have_errors
      end
    end

    scenario "Can log out" do
      sign_in(user) 
      click_link "Logout"
      expect(page).to have_content("You've successfully signed out")
    end
  end


end