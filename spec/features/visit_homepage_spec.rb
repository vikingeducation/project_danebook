require 'rails_helper.rb'

feature "visiting homepage as a new user" do 

  scenario "a new visitor will see a log in button" do 
    visit root_path
    expect(page).to have_button("Log in")
  end

  scenario "a new visitor will create a new Danebook account" do 
    visit root_path
    fill_in("First Name", with: "foo")
    fill_in("Last Name", with: "bar")
    emails = page.all(".form-control")
    page.all(:fillable_field, 'Email')[1].set("foo@bar.com")
    page.all(:fillable_field, 'Password')[1].set("password")
    fill_in("Password Confirmation", with: "password")
    click_button("Sign Up!")
    expect(page).to have_content("Welcome to Danebook!")
  end

end
