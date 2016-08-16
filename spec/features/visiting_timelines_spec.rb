require 'rails_helper.rb'

feature "visting timelines" do 
  let(:user) {create(:user)}
  let(:user2) {create(:user, first_name: "Blah", email: "blah@gmail.com")}  

  scenario "a signed in user should be able to visit any person's timeline" do
    login(user)
    visit "/users/#{user2.id}"
    expect(page).to have_content(user2.first_name)
    expect(page).to have_selector(".btn.btn-primary.center-block")
  end

  scenario "a signed in user should be able to view their own timeline" do 
    login(user)
    visit "/users/#{user.id}"
    expect(page).to have_content(user.first_name)
    expect(page).to have_selector(".btn.btn-primary.center-block")
  end
end