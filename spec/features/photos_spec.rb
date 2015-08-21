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

      expect(page.current_path).to eq(user_photo_path(user, user.photos.last))
      expect(user.photos.count).to eq(1)
      expect(page).to have_content("Photo successfully uploaded!")
    end

  end


  context 'uploading from hard drive' do

    scenario 'with valid size and file type' do
      attach_file('photo[photo]', Rails.root.join('spec', 'support', 'test.jpg'))
      click_button 'Upload!'

      expect(page.current_path).to eq(user_photo_path(user, user.photos.last))
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




feature 'user photo index displays collection of thumbnails' do

  let(:user) { create(:user) }
  let(:image_count) { 5 }

  before do
    sign_in(user)
    image_count.times { user.photos.create(attributes_for(:photo)) }
    visit user_photos_path(user)
  end


  scenario 'displays 16 image thumbnails' do
    expect(page).to have_css('.img-thumbnail', :count => image_count)
  end

end



feature 'photo show page' do
  let(:viewer) { create(:user) }
  let(:photo) { create(:photo) }

  before do
    sign_in(viewer)
    photo.comments.create(attributes_for(:comment, :on_photo, author_id: viewer.id))
    photo.owner.friended_users << viewer
    visit user_photo_path(photo.owner, photo)
  end


  scenario 'displays photo and owner' do
    expect(page).to have_css("img[src*='#{photo.photo.url(:medium)}']")
    expect(page).to have_content(photo.photo_updated_at)
  end


  scenario 'displays comments' do
    expect(page).to have_content(photo.comments.first.body)
  end



  scenario 'user can add a comment'
  scenario 'user can delete a comment'



end