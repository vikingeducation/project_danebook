require 'rails_helper'
require 'pry'

feature 'Sign up user account' do

  before do
    visit root_path
  end

  scenario "Create a new user account" do
    fill_in('First Name', :with => 'Aida')
    fill_in('Last Name', :with => 'Lovelace')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Your New Password', :with => 'Seekrit')
    fill_in('Confirm Your Password', :with => 'Seekrit')
    select("1", from: "user_profile_attributes_birth_day").select_option
    select("1", from: "user_profile_attributes_birth_month").select_option
    select("2000", from: "user_profile_attributes_birth_year").select_option
    choose('user_profile_attributes_gender_male')
    # click_button "Sign Up!"
    expect{ click_button "Sign Up!" }.to change(User, :count).by(1)
    expect(page).to have_content "About Me"
    expect(page).to have_content "Congratulation!"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to create user account with incorrect data" do
    fill_in('First Name', :with => '1')
    fill_in('Last Name', :with => 'Lovelace')
    fill_in('Email', :with => 'Seek@gmail.com')
    fill_in('Your New Password', :with => 'Seekrit')
    fill_in('Confirm Your Password', :with => 'Seekrit')
    select("1", from: "user_profile_attributes_birth_day").select_option
    select("1", from: "user_profile_attributes_birth_month").select_option
    select("2000", from: "user_profile_attributes_birth_year").select_option
    choose('user_profile_attributes_gender_male')
    click_button "Sign Up!"
    expect(page).to have_content "Profile first name is too short"
    expect(page).to have_css ('div.alert-danger')
  end


end

feature 'Login to user account' do
  let(:user){create(:user)}
  let(:profile){create(:profile, :user_id => user.id)}

  before do
    user
    profile
    visit root_path
  end

  scenario "Successfully can login with correct email and password" do
    fill_in('email', :with => user.email )
    fill_in('password', :with => user.password )
    click_button "Log in"
    expect(page).to have_content "You have successfully signed in"
    expect(page).to have_css ('div.alert-success')
  end

  scenario "Unable to login with incorrect password" do
    fill_in('email', :with => user.email )
    fill_in('password', :with => 'Seekreet1' )
    click_button "Log in"
    expect(page).to have_content "We couldn't sign"
    expect(page).to have_css ('div.alert-danger')
  end

end
