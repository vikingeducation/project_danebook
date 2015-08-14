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

    scenario "can upload to his/her photos from local drive" do
      save_and_open_page
      expect(page).to have_content("Add Photo")
      click_link "Add Photo"
      attach_file "photo_picture", @pic_file_path
      expect{click_button "Upload Photo"}.to change(Photo, :count).by(1)
      expect(page).to have_content("You uploaded a photo".upcase)
    end

    scenario "can upload to his/her photos from weblink" do
      expect(page).to have_content("Add Photo")
      click_link "Add Photo"
      fill_in "photo_photo_link", with: "https://www.google.com/images/srpr/logo11w.png"
      expect{click_button "Use Web Photo"}.to change(Photo, :count).by(1)
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
        # expect(page).to have_content("Photo View")
        expect(page).to have_css("img.full-size-photo")
      end

      xscenario 'can set photo as profile/cover photo' do
        #set picture as profile photo
        visit(user_photo_path(user.id, photo.id))
        click_link "Set as Profile"
        expect(page).to have_css("img#" + photo.picture_file_name +
                                                    '_profile')

        #set picture as cover photo
        visit(user_photo_path(user.id, photo.id))
        click_link "Set as Cover"
        expect(page).to have_css("img#"+ photo.picture_file_name +
                                                "_profile")
      end

      context 'photo comments and likes' do

        # let(:friending){create(:friending, friend_id: user.id, friender_id: other_user.id)}

        # let(:friending_inverse){create(:friending,
        #       friend_id: other_user.id, friender_id: user.id)}

        before :each do
          sign_out

          other_user = create(:user, email: "other@email.com")
          sign_in(other_user)
          visit user_posts_path(user.id)
          # make a friend first
          click_link "Friend Me"
          visit (user_photo_path(user.id, photo.id))
        end

        scenario "can view friend's photo show page" do
          expect(page).to have_content("Photo View")
        end

        scenario "can comment on friend user's photo" do
          expect(page).to have_css('input[placeholder="Write a comment..."]')

          fill_in "comment[body]", with: "witty photo comment"
          expect{click_button "Comment"}.to change(Comment, :count).by(1)
          expect(page).to have_content("witty photo comment")
        end

        scenario "can delete own comment on other user's photo" do
          fill_in "comment[body]", with: "witty photo comment"
          click_button "Comment"
          # save_and_open_page
          expect{click_link "Delete"}.to change(Comment, :count).by(-1)
          expect(page).to_not have_content("witty photo comment")
        end

        scenario "can like a photo and then unlike same photo" do
          expect{click_link "Like"}.to change(Like, :count).by(1)

          #check flash msg
          expect(page).to have_content("You have liked this!".upcase)

          expect{click_link "Unlike"}.to change(Like, :count).by(-1)

          #check flash msg
          expect(page).to have_content("YOU HAVE UNLIKED THIS!")
        end
      end
    end
  end
end