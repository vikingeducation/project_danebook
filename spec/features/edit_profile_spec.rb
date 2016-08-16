require 'rails_helper.rb'

feature "Editing your profile", js: true do 
  let(:user) {create(:user, email: "myemail@gmail.com")}
  let(:user2) {create(:user, email: "blah@gmail.com")}

  scenario "a newly logged in user will be able to edit their profile page" do
    login(user)
    click_link("Edit")
    fill_in('user_email', with:"mynewemail@gmail.com")
    save_and_open_page
    click_button("Submit")

    expect(page).to have_text("Your Danebook profile has been updated")
  end

  scenario "a newly logged in user should not have access to another user's edit page" do
    login(user)
    visit "/users/#{user2.id}/profiles/edit"
    #save_and_open_page
    expect(page).to have_content("404")
  end

end