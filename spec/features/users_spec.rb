require 'rails_helper'

feature "Guest interactions" do
  before do
    visit root_path
  end

  scenario "guests are brought to sign up page" do
    expect(page).to have_content "Connect with all your friends!"
  end

  scenario "guests cannot sign in without entering a proper login and email" do
    click_button "Sign In"
    expect(page).to have_content "Connect with all your friends!"
  end

  scenario "guests can sign up" do
    fname = "Foo"
    lname = "Bar"
    email = "wfeegeygrryeryeryer@email.com"
    pw = "password"
    pwc = "password"
    gender = "male"
    fill_in "user_first_name", with: fname
    fill_in "user_last_name", with: lname
    fill_in "user_email", with: email
    fill_in "user_password", with: pw
    fill_in "user_password_confirmation", with: pwc
    page.select "2015", from: 'user_birthday_1i'
    page.select "August", from: 'user_birthday_2i'
    page.select "7", from: 'user_birthday_3i'
    page.choose('user_gender_male')
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(1)
  end

  scenario "successful sign up creates new profile" do
    fname = "Foo"
    lname = "Bar"
    email = "wfeegeygrryeryeryer@email.com"
    pw = "password"
    pwc = "password"
    gender = "male"
    fill_in "user_first_name", with: fname
    fill_in "user_last_name", with: lname
    fill_in "user_email", with: email
    fill_in "user_password", with: pw
    fill_in "user_password_confirmation", with: pwc
    page.select "2015", from: 'user_birthday_1i'
    page.select "August", from: 'user_birthday_2i'
    page.select "7", from: 'user_birthday_3i'
    page.choose('user_gender_male')
    expect{ find("#sign-up-submit").click }.to change(Profile, :count).by(1)
  end

  scenario "sign up requires all attributes" do
    fname = "Foo"
    lname = "Bar"
    email = "wfeegeygrryeryeryer@email.com"
    pw = "password"
    pwc = "password"
    gender = "male"
    fill_in "user_first_name", with: fname
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)
    fill_in "user_last_name", with: lname
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)
    fill_in "user_email", with: email
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)
    fill_in "user_password", with: pw
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)
    fill_in "user_password_confirmation", with: pwc
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)

    fill_in "user_first_name", with: fname
    fill_in "user_last_name", with: lname
    fill_in "user_email", with: email
    fill_in "user_password", with: pw
    fill_in "user_password_confirmation", with: pwc
    page.select "2015", from: 'user_birthday_1i'
    page.select "August", from: 'user_birthday_2i'
    page.select "7", from: 'user_birthday_3i'
    page.choose('user_gender_male')
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(1)
  end

  let!(:user){ create(:user) }
  scenario "guests cannot sign up with duplicate email" do
    fname = "Foo"
    lname = "Bar"
    email = "testest@test.com"
    pw = "password"
    pwc = "password"
    gender = "male"
    user.email = email
    fill_in "user_first_name", with: fname
    fill_in "user_last_name", with: lname
    fill_in "user_email", with: email
    fill_in "user_password", with: pw
    fill_in "user_password_confirmation", with: pwc
    page.select "2015", from: 'user_birthday_1i'
    page.select "August", from: 'user_birthday_2i'
    page.select "7", from: 'user_birthday_3i'
    page.choose('user_gender_male')
    expect{ find("#sign-up-submit").click }.to change(User, :count).by(0)
  end

  scenario "signing up takes user to profile" do
    fname = "Foo"
    lname = "Bar"
    email = "tesdf@test.com"
    pw = "password"
    pwc = "password"
    gender = "male"
    fill_in "user_first_name", with: fname
    fill_in "user_last_name", with: lname
    fill_in "user_email", with: email
    fill_in "user_password", with: pw
    fill_in "user_password_confirmation", with: pwc
    page.select "2015", from: 'user_birthday_1i'
    page.select "August", from: 'user_birthday_2i'
    page.select "7", from: 'user_birthday_3i'
    page.choose('user_gender_male')
    click_button "Sign Up!"
    expect(page).to have_content "About"
  end
end

feature "User log in" do
  before do
    visit root_path
  end

  scenario "user logs in" do
    user = create(:user)
    user.profile = create(:profile)
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_button "Sign In"
    expect(page).to have_content "About"
  end
end

feature "User is logged in" do
  before do
    user = create(:user)
    user.profile = create(:profile)
    visit user_path(user)
    save_and_open_page
  end

  scenario "user clicks timeline link" do
    click_link "Timeline"
    expect(page).to have_content "Timeline"
  end
end