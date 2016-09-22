require 'rails_helper.rb'


feature "Signing in" do
  let(:user) {create(:user)} 

  scenario "a user who has an account will log in" do   
    login(user)
    expect(page).to have_content("You've successfully signed into Danebook!")
  end
end