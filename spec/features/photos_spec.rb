require 'rails_helper'

describe 'Photos' do
  let(:male){create(:male)}
  let(:user){create(:user, :gender => male)}
  let(:profile_photo){create(:profile_photo, :user => user)}
  let(:cover_photo){create(:cover_photo, :user => user)}
  let(:other_user){create(:user, :gender => male)}
  let(:other_user_photo){create(:cover_photo, :user => other_user)}
  let(:friend_request){create(:friend_request, :initiator => user, :approver => other_user)}

  before do
    visit login_path
    sign_in(user)
    friend_request.accept
  end

  describe 'listing' do
    it 'displays all photos for a user' do
      profile_photo
      visit user_photos_path(user)
      expect(page).to have_content("Uploaded on #{profile_photo.date}")
    end
  end

  describe 'showing' do
    it 'displays a single photo' do
      profile_photo
      visit user_photo_path(user, profile_photo)
      image_src = page.find('.photo-show-container img')['src']
      expect(image_src).to eq(profile_photo.file.url)
    end

    context 'the photo belongs to the current user' do
      before do
        profile_photo
        visit user_photo_path(user, profile_photo)
      end

      it 'displays a link to set the photo to the profile photo' do
        expect(page).to have_link('Set as Profile Photo')
      end

      it 'displays a link to set the photo to the cover photo' do
        expect(page).to have_link('Set as Cover Photo')
      end

      it 'displays a link to delete the photo' do
        expect(page).to have_link('Delete Photo')
      end
    end

    context 'the photo does not belong to the user' do
      before do
        other_user_photo
        visit user_photo_path(other_user, other_user_photo)
      end

      it 'does not display a link to set the photo to the profile photo' do
        expect(page).to_not have_link('Set as Profile Photo')
      end

      it 'does not display a link to set the photo to the cover photo' do
        expect(page).to_not have_link('Set as Cover Photo')
      end

      it 'does not display a link to delete the photo' do
        expect(page).to_not have_link('Delete Photo')
      end

    end
  end

  describe 'photo actions' do
    before do
      profile_photo
      visit user_photo_path(user, profile_photo)
    end

    describe 'setting the profile photo' do
      it 'results in the profile photo being set to the photo' do
        click_link('Set as Profile Photo')
        image_src = page.find('.profile-image-container img')['src']
        expect(image_src).to eq(profile_photo.file.url)
      end
    end

    describe 'setting the cover photo' do
      it 'results in the cover photo being set to the photo' do
        click_link('Set as Cover Photo')
        background_style = page.find('.cover-image-container')['style']
        expect(background_style).to match("background-image: url('#{profile_photo.file.url}')")
      end
    end

    describe 'deleting' do
      it 'results in the photo being destroyed' do
        expect {click_link('Delete Photo')}.to change(Photo, :count).by(-1)
      end
    end
  end
end


