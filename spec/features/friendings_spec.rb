require 'rails_helper'

feature 'Friending' do

  let(:profile) {create(:profile)}
  let(:other_profile) {create(:profile)}
  let(:user){ create(:user, profile: profile)}
  let(:other_user){ create(:user, :email => "foo2@email.com", profile: profile)}

  before do
    visit root_path
    sign_in(user)
    visit user_path(other_user.id)
  end

  scenario "'friend' button appears for users who are not friends with current user'" do
      expect(page).to have_content("Friend #{other_profile.first_name}")
  end


  scenario "'unfriend' button appears for users who are friends with current user'" do
      click_link("Friend #{other_profile.first_name}")
      expect(page).to have_content("Unfriend #{other_profile.first_name}")
  end









end