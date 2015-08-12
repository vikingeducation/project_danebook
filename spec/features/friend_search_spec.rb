require 'rails_helper'

include LoginMacros

feature "Friend search" do

  let(:user) {create(:user)}

  before do
    visit root_path
    sign_in(user)
  end

  #--------------- Happy Path!!! -----------------

  scenario "User should be able find other users that matches the search query" do
    another_user = create(:user, first_name: "Foolicious")
    # Foo goes to search form in navbar and tries to find his namesake foo
    fill_in "Search for Users", with: "foo"
    click_button "Search"

    # Foo should be able to see all users that include his name
    expect(page).to have_content("#{another_user.name}")
    expect(page).to have_content("Friend Me!")

  end
end