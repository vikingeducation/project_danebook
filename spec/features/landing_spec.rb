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
      #this is working when it shouldn't fix! 
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
 
  end

  context "logged in user" do
    
  end


end