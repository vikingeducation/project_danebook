require 'rails_helper'

feature 'signing up a new user' do

  let(:user){ create(:user) }

  before do
    visit root_path

    #pre-filling in signup form
    fill_in "user_first_name", with: "SuperCool"
    fill_in "user_last_name", with: "foobar"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    select("January", :from => 'user_birthdate_2i')
    select("2", :from => 'user_birthdate_3i')
    select("2000", :from => 'user_birthdate_1i')
    choose("user_profile_attributes_gender_female")
  end

  scenario 'should add a new user' do

    #filling in sign up form below!
    fill_in "user_email", with: "SuperCool@test.com"

    expect{click_button "Sign Up"}.to change(User, :count).by(1)

    expect(page).to have_content("Signed in as SuperCool")

    expect(page).to have_content("Your account was successfully created!".upcase)
  end

  scenario 'should redirect to profile page' do
    fill_in "user_email", with: "SuperCool2@test.com"
    click_button "Sign Up"
    expect(page).to have_content("Edit Profile")
    expect(page).to have_content("SuperCool2@test.com")
  end

  scenario 'should redirect to sign up if there are errors' do

    #this specific setup is using a non-unique email to raise error
    fill_in "user_email", with: user.email

    expect{click_button "Sign Up"}.to change(User, :count).by(0)

    expect(page).to have_content("ERROR: WE COULDN'T CREATE YOUR ACCOUNT.")
  end

end