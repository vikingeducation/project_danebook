require 'rails_helper'

include LoginMacros

feature "User search" do

  let(:user) {create(:user)}
  let(:another_user) { create(:user, first_name: "Foobear") }

  before do
    visit root_path
    sign_in(user)
  end

  scenario "User should be able find other users that matches the search query" do
    another_user

    # Foo goes to search form in navbar and tries to find his namesake foo
    search(terms: "foo")

    # Foo should be able to see all users that include his name
    expect(page).to have_content("#{another_user.name}")
    expect(page).to have_content("Friend Me!")

  end

  scenario "User should be able to unfriend a user if they currently are friends" do
    create(:friending, friender: user, target: another_user)
    # Foo goes to search form in navbar and tries to find his namesake foo
    search(terms: "foo")

    # Foo should be able to see all users that include his name
    expect(page).to have_content("#{another_user.name}")
    expect(page).to have_content("Unfriend Me")

  end

  scenario "User should be able to see all users if form is left blank" do
    create_list(:user, 20)
    # Foo goes to search form in navbar leaving a blank field
    search

    # Foo should be able to see all users including himself
    expect(page).to have_selector('#search-results > div', count: 21)

  end

  scenario "User should only see 30 results per page if the result is too large" do
    create_list(:user, 50)
    # Foo goes to search form in navbar leaving a blank field
    search

    # Foo should be able to see all users including himself
    expect(page).to have_selector('#search-results > div', count: 30)

  end
end