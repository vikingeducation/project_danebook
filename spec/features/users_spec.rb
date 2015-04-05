require 'rails_helper'


feature 'User accounts' do
  before do
    visit root_path
  end
  let(:user){ create(:user) }

  #CONCERNS:: identifying right fillin with navbar present
  scenario "sign up as a new user" do
    within("div.sign-up-form") do
      birthday = "1/1/61"
      fill_in "Email", with: user.email, :match => :prefer_exact
      fill_in "Password", with: "greybull", :match => :prefer_exact
      fill_in "Password confirmation", with: "greybull"
      fill_in "Birthday", with: birthday
    end
    click_button "Create User"
    expect(page).to have_content "1/1/61"
    expect(page).to have_content "About Me"
  end

  scenario "sign in as a current user" do
    within("nav") do #specifies to look in navbar
      fill_in "email", with: user.email
      fill_in "password", with: "greybull"
      click_button "Log in"
    end
    binding.pry
    expect(page).to have_content "Basic Information"
  end

  scenario "log out as a current user" do
    within("div.sign-up-form") do
      birthday = "1/1/61"
      fill_in "Email", with: "schweezy@schwad.com", :match => :prefer_exact
      fill_in "Password", with: "foobarz", :match => :prefer_exact
      fill_in "Password confirmation", with: "foobarz"
      fill_in "Birthday", with: birthday
    end
    click_button "Create User"
    click_link  "Logout"

    expect(page).to have_content "Log In"
  end
end

feature 'User actions and interactions' do
  scenario "Post on Personal Page"
  scenario "Like someone else's post"
  scenario "Cannot edit another person's page"
  scenario "Cannot like more than once"

end

feature 'User persistence and auth' do

end