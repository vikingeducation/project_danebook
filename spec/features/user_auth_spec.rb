require 'rails_helper'

include LoginMacros

feature "Users sign ups" do

  before do
    visit root_path
  end

  #--------------- Happy Path!!! -----------------

  scenario "User should be able to sign up when proper information is provided" do

    sign_up

    expect{click_button "Sign Up"}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome to Danebook Foo Bar")
    expect(page).to have_content("Signed in as Foo Bar")

  end

  #--------------- Sad Path :( -----------------

  context "User should get meaningful error messages if mistakes were made" do

    scenario "User forgets to fill out first name field" do
      sign_up(first_name: "")
      click_button "Sign Up"
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("First name is too short (minimum is 1 character)")
    end

    scenario "User is skeptical about social media websites and doesn't provide a last name" do
      sign_up(last_name: "")
      click_button "Sign Up"
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Last name is too short (minimum is 1 character)")
    end

    scenario "User doesn't know what email is so he/she just leaves it blank and hopes for the best" do
      sign_up(email: "")
      click_button "Sign Up"
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Email is too short (minimum is 6 characters)")
    end

    scenario "A random web robot tries to fool my powerful regex and types in gibberish in the email field" do
      sign_up(email: "we;foj;32rl;kfj")
      click_button "Sign Up"
      expect(page).to have_content("Email is invalid")
    end

    scenario "User doesn't trust his password with Danebook :(" do
      sign_up(password: "")
      click_button "Sign Up"
      expect(page).to have_content("Password can't be blank")
    end

    scenario "User has a typo in his password confirmation" do
      sign_up(password: "password", password_confirmation: "passwrod")
      click_button "Sign Up"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "Form is still valid if user doesn't want to disclose his age and gender and null values are handled" do
      sign_up(month: "", day: "", year: "", gender: "")
      expect{click_button "Sign Up"}.to change(User, :count).by(1)
      expect(page).to have_content("No birthday provided")
    end

  end

  # ------------------ Bad Path! 😠 *Angry Emoji* ---------------

  scenario "User was named 'DROP TABLE users' by overzealous parents, but handled it gracefully" do
    sign_up(first_name: "; DROP TABLE users;", last_name: "Smith")
    expect{click_button "Sign Up"}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome to Danebook ; DROP TABLE users; Smith!")
  end

end

feature "logging in" do

  let(:user) {create(:user)}

  before do
    visit root_path
  end

  #--------------- Happy Path!!! -----------------

  scenario "as an existing user I want to be able to login with my credentials" do
    # save_and_open_page
    sign_in(user)
    expect(page).to have_content("You've successfully signed in")
  end

  scenario "I am concerned with my privacy so I don't want to be remembered past the session" do
    # Check cookie wasn't present to begin with
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
    sign_in(user, remember_me: false)
    # Check cookie is now existing
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).not_to be_nil
    delete_temporary_cookies
    visit current_path # Refresh the page
    # Check cookie was deleted because it was temporary
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
  end

  scenario "as an existing user I want to be remembered through the years so I don't have to login every new session" do
    # Check cookie wasn't present to begin with
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).to be_nil
    sign_in(user, remember_me: true)
    # Check cookie is now existing
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).not_to be_nil
    delete_temporary_cookies
    visit current_path # Refresh the page
    # Check cookie still exists because it was permanent
    expect(Capybara.current_session.driver.request.cookies.[]('auth_token')).not_to be_nil
  end

  #--------------- Sad Path :( -----------------

  scenario "I will be told if I have a bad input" do
    sign_in(user, email: "Iforgot!", password: "IDK")
    expect(page).to have_content("Wrong email/password combination, please try again!")
  end

  # ------------------ Bad Path! 😠 *Angry Emoji* ---------------

  scenario "I will be redirected to my timeline against my will if I am signed in and try to sign up a second time, or if I chose to be remembered" do
    sign_in(user, remember_me: "something truthy")
    delete_temporary_cookies
    visit root_path
    expect(page).to have_content("Welcome back #{user.name}")
    expect(current_path).to eq(user_timeline_path(user))
  end

  scenario "I cannot login with a stolen auth_token" do
    # Kidding! I actually don't think I can test this
  end

end