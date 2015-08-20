require 'rails_helper'


feature 'current user uploading a photo (via their Photos page)' do

  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit user_photos_path(user)
    click_link "Add Photo"
  end


  context 'uploading from the web' do

    scenario 'with valid size and file type' do
      fill_in 'photo[photo_from_url]', with: 'https://www.google.com/images/srpr/logo11w.png'
      click_button 'Use Web Photo'

      expect(page.current_path).to eq(user_photos_path(user))
      expect(user.photos.count).to eq(1)
      expect(page).to have_content("Photo successfully uploaded!")
    end

  end


  context 'uploading from hard drive' do

    scenario 'with valid size and file type' do
      attach_file('photo[photo]', Rails.root.join('spec', 'support', 'test.jpg'))
      click_button 'Upload!'

      expect(page.current_path).to eq(user_photos_path(user))
      expect(user.photos.count).to eq(1)
      expect(page).to have_content("Photo successfully uploaded!")
    end

  end


  scenario 'with invalid file type' do
    attach_file('photo[photo]', Rails.root.join('spec', 'support', 'bad_photo.txt'))
    click_button 'Upload!'

    expect(page.current_path).to eq(user_photos_path(user))
    expect(user.photos.count).to eq(0)
    expect(page).to have_content("Photo not saved")
    expect(page).to have_button("Upload!")
  end


end



feature 'photo collection displays thumbnail' do

end