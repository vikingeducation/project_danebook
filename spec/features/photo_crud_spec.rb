require 'rails_helper'

feature 'User photo CRUD' do

  let(:user){create(:user)}
  let(:other_user){create(:user)}


  scenario 'redirects to sign in page when user not logged in' do
    visit user_photos_path(user.id)
    expect(page).to have_content("NOT AUTHORIZED, PLEASE SIGN IN!")
  end

  context 'upload and display photo' do

    before do
      sign_in(user)
      visit user_photos_path(user.id)
      @pic_file_path = File.expand_path('../support/test.png', File.dirname(__FILE__))
    end

    scenario "can upload to his/her photos" do
      expect(page).to have_content("Add Photo")
      click_link "Add Photo"
      attach_file "photo_picture", @pic_file_path
      expect{click_button "Upload Photo"}.to change(Photo, :count).by(1)
      expect(page).to have_content("You uploaded a photo".upcase)
    end


    context 'user already has a photo' do

      let(:photo){create(:photo, user_id: user.id)}

      before :each do
      #   user.photos = create_list(:photo, 1)
      #   user.save
      #   @photo = user.photos.first
        photo
        visit user_photos_path(user.id)
      end

      scenario 'can see thumbnail of their photo' do
        expect(page).to have_content("Uploaded #{user.photos.first.created_at}")
      end

      scenario 'can see individual photo by clicking on thumbnail' do
        click_link "#{photo.picture_file_name}"
        expect(page).to have_content("Photo View")
      end

      scenario 'can set photo as profile/cover photo' do
        visit(user_photo_path(user.id, photo.id))
        click_link "Set as Profile"
        expect(page).to have_css(user.profile_photo.picture_file_name + "_profile")
        click_link "Set as Cover"
        expect(page).to have_css(user.profile_photo.picture_file_name + "_profile")
      end

      context 'photo comments and likes' do

        let(:friending){create(:friending, friend_id: user.id, friender_id: other_user.id)}

        before :each do
          sign_out

          other_user = create(:user, email: "other@email.com")
          sign_in(other_user)
          friending

          visit user_photo_path(user.id, photo.id)
        end

        xscenario "can comment on friend user's photo" do
          expect(page).to have_css('textarea[placeholder="Write a comment..."]')

          fill_in :body, with: "witty photo comment"
          expect{click_button "Comment"}.to change(Comment, :count).by(1)
          expect(page).to have_content("witty photo comment")
        end

        xscenario "can delete own comment on other user's photo" do
          fill_in :body, with: "witty photo comment"
          click_button "Comment"

          expect{click_link "Delete"}.to change(Photo, :count).by(-1)
          expect(page).to_not have_content("witty photo comment")
        end

        xscenario "can like a photo and then unlike same photo" do
          expect{click_link "Like"}.to change(Like, :count).by(1)

          #check flash msg
          expect(page).to have_content("You have liked this!".upcase)

          expect{click_link "Unlike"}.to change(Like, :count).by(-1)

          #check flash msg
          expect(page).to have_content("You unliked this!".upcase)
        end
      end
    end
  end
end