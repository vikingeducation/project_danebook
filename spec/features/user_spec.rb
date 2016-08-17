require 'rails_helper'

feature "User" do 

  let!(:saved_user){ create(:user) }
  let!(:user){ build(:user, :email => "foobarbaz@email.com") }

  before do
    visit root_path
  end

  describe "Sign in" do 

    specify "a user can sign in with correct email and password" do 
      fill_in('email', with: user.email)
      fill_in('password', with: user.password)

      expect(page).to have_content("You've successfully signed in")
    end
  end

  describe "Sign up" do

    specify "a new user must fill in a complete form to sign up" do 
      fill_in('user_first_name', with: user.first_name)

      click_on('signup-button')

      expect(page).to have_content("Password can't be blank")
    end

    specify "a new user can sign up if they provide all information" do 

      fill_in('user_first_name', with: user.first_name)
      fill_in('user_last_name', with: user.last_name)
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: user.password)
      fill_in('user_password_confirmation', with: user.password)
      select('16', from: "user_profile_attributes_birth_date_3i")
      select('August', from: "user_profile_attributes_birth_date_2i")
      select('1990', from: "user_profile_attributes_birth_date_1i")
      choose('gender-input-male')


      click_on('signup-button')

      expect(page).to have_content("Created new user!")
    end
  end


end