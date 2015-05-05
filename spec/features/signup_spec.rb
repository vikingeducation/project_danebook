require 'rails_helper'

feature 'Create a New User' do
  before do
    visit root_path
  end

  # `scenario` is an alias for `it`
  context "With proper user attributes" do

    scenario 'creates a new user' do
      attrs = FactoryGirl.attributes_for(:user)
      profile_attrs = FactoryGirl.attributes_for(:profile)

      fill_in "user[first_name]", with: attrs[:first_name]
      fill_in "user[last_name]", with: attrs[:last_name]
      fill_in "user[email]", with: attrs[:email]
      fill_in "user[password]", with: attrs[:password]
      fill_in "user[password_confirmation]", with: attrs[:password]


      # select birthday
      select profile_attrs[:month], from: "user[profile_attributes][month]"
      select profile_attrs[:day], from: "user[profile_attributes][day]"
      select profile_attrs[:year], from: "user[profile_attributes][year]"

      choose 'user_profile_attributes_gender_rather_not_say'


      expect{ click_button "Sign Up!" }.to change(User, :count).by(1)

      # verify that we've been redirected to that user's page
      expect(page).to have_content "#{attrs[:first_name]} #{attrs[:last_name]}"

      # Test the Flash
      expect(page).to have_content "Welcome to Danebook!"

    end
  end

  context 'Without proper attributes' do

    scenario "Rerender with errors" do

      first_name = "New"
      last_name = "User"
      fill_in "user[first_name]", with: first_name
      fill_in "user[last_name]", with: last_name

      expect{ click_button "Sign Up!" }.not_to change(User, :count)

      # verify that we've been redirected to that user's page
      expect(page).not_to have_content "#{first_name} #{last_name}"

      # Test the Flash
      expect(page).to have_content "Please make sure all your information was correct."

    end

  end

  context 'When the user already exists' do

    let(:user){ FactoryGirl.create(:user) }

    scenario "Creation fails and rerenders" do

      fill_in "user[first_name]", with: user.first_name
      fill_in "user[last_name]", with: user.last_name
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: FactoryGirl.attributes_for(:user)[:password]
      fill_in "user[password_confirmation]", with: FactoryGirl.attributes_for(:user)[:password]

      # select birthday
      select user.profile.month, from: "user[profile_attributes][month]"
      select user.profile.day, from: "user[profile_attributes][day]"
      select user.profile.year, from: "user[profile_attributes][year]"

      choose 'user_profile_attributes_gender_rather_not_say'


      expect{ click_button "Sign Up!" }.not_to change(User, :count)

      # verify that we've been redirected to that user's page
      expect(page).not_to have_content "#{user.first_name} #{user.last_name}"

      # Test the Flash
      expect(page).to have_content "Please make sure all your information was correct."

    end
  end

end