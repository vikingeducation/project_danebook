require 'rails_helper.rb'

feature "Editing your profile" do 
  let(:user) {create(:user, email: "myemail@gmail.com")}
  let(:user2) {create(:user, email: "blah@gmail.com")}

  scenario "a newly logged in user will be able to edit their profile page" do
    login(user)
    click_link("Edit")
    fill_in('user_email', with:"mynewemail@gmail.com")
    click_button("Submit")

    expect(page).to have_text("Your Danebook profile has been updated")
  end

end