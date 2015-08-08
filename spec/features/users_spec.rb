require 'rails_helper'

feature 'User accounts' do
  before do
    # go to the home page
    visit root_path
  end

  scenario "add a new user" do
    
    fill_in "Name", with:  "Foo"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "foobarfoobar"
    fill_in "Password confirmation", with: "foobarfoobar"

    expect{ click_button "Create User" }.to change(User, :count).by(1)

    expect(page).to have_content "user show for #{name}"
    expect(page).to have_content "Created new user!"    

  end
end 
