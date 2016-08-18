require 'rails_helper'

feature 'User signup' do
  before do
    visit root_path
  end

  scenario "user sign-up" do
    sign_up("Foo", "Bar")
    expect{ click_on("Sign Up!") }.to change(User,:count).from(0).to(1)
    expect(find('#big-profile-name')).to have_content("Foo Bar")
    expect(find('#profile-name')).to have_content("Foo")
  end

  scenario "user signs up with missing information" do
    sign_up
    expect{ click_on("Sign Up!") }.not_to change(User,:count)
    expect(page).to have_content("can't be blank")
  end

  scenario "user signs up with same email" do
    create(:user, email: "foo@bar.com")
    sign_up("Foo", "Bar")
    click_on("Sign Up!")
    expect(page).to have_content("has already been taken")
  end
end

feature 'User sign-in' do

  before do
    visit root_path
  end

  let!(:user){ create(:user) }
  let!(:profile){ create(:profile, user: user) }

  scenario "user with an account logs in" do
    login(user)
    expect(current_path).to eq(user_path(user)) 
  end

  scenario "user puts in wrong password" do
    wrong_login(user)
    expect(page).to have_content("We couldn't sign you in")
    expect(current_path).to eq(root_path)
  end

  scenario "user logs out" do
    login(user)
    click_link("Logout")
    expect(current_path).to eq(root_path)
  end

end

feature 'about page' do

  before do
    visit root_path
    user = create(:user)
    profile = create(:profile, user: user)
    login(user)
  end

  scenario "logged in user on their own about page" do
    expect(page).to have_content("Edit Profile")
    click_link("Edit Profile")
    expect(page).to have_selector('textarea')
    expect(page).to have_selector('#save_changes')
    edit_profile("These are inspiring words")
    expect(page).to have_content("These are inspiring words")
  end

  scenario "user on another user's about page" do
    user_2 = create(:user)
    profile_2 = create(:profile, user: user_2)
    visit user_path(user_2)
    expect(page).not_to have_content("Edit Profile")
  end

end