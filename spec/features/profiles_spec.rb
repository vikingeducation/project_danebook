require 'rails_helper'

feature 'Editing Profile' do

  before do
    visit root_path
  end

  let(:profile) {create(:profile)}
  let(:user){ create(:user, :profile => profile )}

  scenario "editing a profile with valid params succeeds" do
    sign_in(user)
    click_link("Edit Profile")
    fill_in "user[profile_attributes][college]", with: "Harvard"
    fill_in "user[profile_attributes][hometown]", with: "Harvard"
    fill_in "user[profile_attributes][currently_lives]", with: "Harvard"
    click_button("Save Changes")
    expect(page).to have_css(".alert-success")
  end

  scenario "editing a profile with invalid params fails" do
    sign_in(user)
    click_link("Edit Profile")
    fill_in "user[profile_attributes][telephone]", with: "111"
    click_button("Save Changes")
    expect(page).to have_css(".alert-danger")
  end




end