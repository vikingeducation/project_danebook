require 'rails_helper.rb'

feature "A user can create a new post" do
  let(:user) {create(:user)}
  let(:user2) {create(:user, email: "blahblah2@gmail.com")} 

  scenario "on their wall" do 
    login(user)
    click_on("Timeline")
    filled_in = "HELLLOO!!"
    fill_in('post[content]', with: filled_in)
    click_on("Post to the world!")
    expect(page).to have_content(filled_in)

  end

  scenario "A user can create a post on someone else's wall" do 
    login(user)
    visit "/users/#{user2.id}"
    filled_in = "HELLLOO!!"
    fill_in('post[content]', with: filled_in)
    click_on("Post to the world!")
    expect(page).to have_content(filled_in)
  end

end