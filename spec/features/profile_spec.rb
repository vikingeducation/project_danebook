require 'rails_helper'


feature 'visitors' do

  let(:user) { build(:user) }

  scenario "cannot access profile" do
    user.save
    visit user_profile_path(user)

    expect(page).to have_content('Error! Not authorized, please sign in!')
  end

end



feature 'logged in users' do

  let(:user) { build(:user) }

  before do
    user.save
    log_in(user)
    visit edit_user_profile_path(user)
  end

  scenario "can edit their own profile" do
    new_hometown = "Lake Cameron"
    find('input#profile_hometown').set(new_hometown)
    click_on("Save Changes")

    expect(page).to have_content('Success! Updates saved')
    expect(page).to have_content(new_hometown)
  end


  scenario "invalid profile attributes are rejected" do
    overshare = 'I am super cool'*100
    find('#profile_about_me').set(overshare)
    click_on("Save Changes")

    expect(page).to have_content("Error! Unable to save profile")
  end


end