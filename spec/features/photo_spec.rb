require 'rails_helper'

feature 'Photo Actions' do
  let(:user){ create(:user, :with_profile, :with_accepted_friend_request)}
  let(:friend){ create(:user, :with_profile)}
  let(:photo){ create(:photo, user: user)}
  let(:test_photo){ create(:photo, user: user, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/images/thumbnail_missing.png'), 'image/png'))}
  let(:cover){create(:photo, user: user, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/images/cover.png'), 'image/png')) }
  context 'logged out'
  context 'Logged in' do
    before do
      login_as(user, scope: :user)
      photo
    end
    scenario 'Clicking \'Add Photos\' leads to photo upload page' do
      visit user_photos_path(user)
      click_link 'Add Photos'
      expect(page).to have_button('Upload Photo')
      expect(page).to have_button('Use Web Photo')
    end
    scenario 'Can only add photos to own account' do
      visit user_photos_path(create(:user, :with_profile))
      expect{ click_button 'Add Photo' }.to raise_error(Capybara::ElementNotFound)
    end
    scenario 'Can upload photo from hard drive' do
      visit upload_user_photos_path(user)
      page.attach_file('photo[image]', Rails.root + 'spec/images/thumbnail_missing.png')
      expect{ click_button 'Upload Photo'}.to change(Photo, :count).by(1)
    end
    scenario 'Can upload photo from web' do
      visit upload_user_photos_path(user)
      fill_in 'photo[image]', with: 'https://68.media.tumblr.com/avatar_b4b457657a2d_128.png'
      expect{ click_button 'Use Web Photo'}.to change(Photo, :count).by(1)
    end
    scenario 'Can view own photo' do
      visit user_photos_path(user)
      first('figure a').click
      expect(page).to have_css('img[id="photo"]')
    end
    scenario 'Can set profile photo' do
      visit photo_path(test_photo)
      click_link 'Set as Profile'
      expect(page.find('.profile-pic')['src']).to have_content('thumbnail_missing.png')
    end
    scenario 'Can set cover photo' do
      visit photo_path(cover)
      click_link 'Set as Cover'
      expect(page.find('.profile-cover')['style']).to have_content('cover.png')
    end
    scenario 'Can delete photo' do
      visit photo_path(test_photo)
      expect{ click_link 'Delete Photo' }.to change(Photo, :count).by(-1)
    end

  end
  context  'logged in as friend' do
    before do
      login_as(user.friendees.first, scope: :user)
      photo
    end
    it 'Can view photo' do
      visit user_photos_path(user)
      first('figure a').click
      expect(page).to have_css('img[id="photo"]')
    end
    it 'Cannot delete photo' do
      visit photo_path(cover)
      expect{ click_link 'Delete Photo'}.to raise_error(Capybara::ElementNotFound)
    end
  end
end
