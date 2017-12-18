require 'rails_helper'

describe User do
  let(:user){ create(:user) }
  let(:profile){ create(:profile, user: user) }

  it "is valid with default attributes" do
    expect(user).to be_valid
  end

  it "user has an email address" do
    expect(user.email).not_to eq("")
  end

  it "user last name has to be the correct length" do
    expect(profile.lastname.length).to be_between(2,24)
  end

  it "user currently lives field has to be the correct length" do
    expect(profile.currently_lives.length).to be_between(2,30)
  end

  describe "User Associations" do
     it "responds to the posts association" do
      expect(user).to respond_to(:posts)
    end
    it "responds to the likes association" do
      expect(user).to respond_to(:likes)
    end
    it "responds to the comments association" do
      expect(user).to respond_to(:comments)
    end
  end

end

# Feature Integration testing using Capybara
feature 'Visitor' do
  before do
    # go to the home page
    visit root_path
  end

  scenario "see the homepage to sign up or sign in" do
    visit root_path
    expect(page).to have_content "Connect with all your friends"
  end

  scenario "I want to sign up" do
    name = "footest"
    fill_in "input-firstname", with: name
    fill_in "input-lastname", with: "test"
    fill_in "inputEmail2", with: "#{name}@bar.com"
    fill_in "password2", with: "foobar"
    fill_in "password3", with: "foobar"
    choose('user_profile_attributes_gender_female')
    expect{ click_button "Sign Up!" }.to change(User, :count).by(1)
  end

  scenario "I can't sign up without the required fields" do
    name = "footest2"
    fill_in "input-firstname", with: name
    fill_in "input-lastname", with: "test"
    fill_in "inputEmail2", with: "#{name}@bar.com"
    fill_in "password2", with: "foobar"
    fill_in "password3", with: "foobar"
    expect{ click_button "Sign Up!" }.to change(User, :count).by(0)
  end
end


feature 'User accounts' do
  let(:user){create(:user)}
  let(:profile){ create(:profile,:user => user)}
  before do
    user
    profile
    visit root_path
  end

  scenario "I want to sign in to my account" do
    fill_in "emailInput1", with: user.email
    fill_in "password", with: "foobar"
    click_button "Sign in"
    expect(page).to have_content profile.firstname
    expect(page).to have_content "You've successfully signed in"
  end

  scenario "I can't sign into my account with no password" do
    fill_in "emailInput1", with: user.email
    fill_in "password", with: ""
    click_button "Sign in"
    expect(page).to have_content "Connect with all your friends!"
    expect(has_button?("Sign in")).to be true
  end

  scenario "I can't sign into account with incorrect password" do
    fill_in "emailInput1", with: user.email
    fill_in "password", with: "Wrong password"
    click_button "Sign in"
    expect(page).to have_content "Connect with all your friends!"
    expect(has_button?("Sign in")).to be true
  end
end