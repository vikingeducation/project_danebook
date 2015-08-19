require 'rails_helper'


feature 'current user can upload a photo (via their Photos page)' do

  let(:user) { create(:user) }

  before do
    visit user_photos_path(user)
    click_button "Add Photo"
  end


  context 'uploading from the web' do

    scenario 'with valid size and file type' do
      photo = nil
      # enter photo url and click button

      # expect to redirect back to user photos
      expect(page.current_path).to eq(user_photos_path(user))
      # expect photo count to increase by 1
      expect{ user.photos.count }.to change.by(1)
      # expect new photo to be there
      expect(page).to have_content(photo)
    end

  end


  context 'uploading from hard drive' do

    xscenario 'with valid size and file type' do
      # click button and select file
      # expect to redirect back to user photos
      # expect photo count to increase by 1
      # expect new photo to be there
    end

  end



  scenario 'with too large a file'


  scenario 'with invalid file type'


end



feature 'photo collection displays thumbnail' do

end