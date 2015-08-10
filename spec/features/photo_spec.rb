require 'rails_helper'

feature 'Uploading Photos' do

  scenario 'user uploads photo to own page' do
    visit root_path
    login_user
    first(:link, 'Photos').click
    attach_file "Upload", "spec/asset_specs/images/test_photo.jpg"
    click_button "Upload"
    expect(page).to have_content("Photos (1)")
  end

end
