require 'rails_helper'

feature 'photos' do
  
  before do
      visit root_path
      user = create(:user)
      profile = create(:profile, user: user)
      login(user)
      visit(user_photos_path(user))
    end
  
  scenario 'adding photos' do
    upload_photo
    expect(page).to have_content("Photos(1)")
    expect(page.has_selector?('.thumbnail')).to be_true
  end

  scenario 'clicking on a photo' do
    upload_photo
    click_on("Photo")
    expect(current_path).to eq(photo)
  end

  feature 'selecting a photo as profile or cover photo' do
    upload_photo
    click_on("Photo")
    expect(page).to have_content("profile")
    expect(page).to have_content("cover")
  end

  feature 'commenting on a photo' do
    upload_photo
    click_on("Photo")
    #fill in comment and press enter
    #expect page to have one comment
    #delete the comment
    #expect page to have no comments
  end

  feature 'liking a photo' do
    upload_photo
    click_on("Photo")
    #click "Like"
    #expect page to have one like
    #click "Unlike"
    #expect page to have no likes
  end

end


