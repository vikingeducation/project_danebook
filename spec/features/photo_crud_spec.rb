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
    end

    scenario "can upload to his/her photos" do
      expect(page).to have_content("Add Photo")
      attach_file  #find out format of form
      expect{click_button "Upload"}.to change(Photo, :count).by(1)

      expect(page).to have_content("...") #check for flash msg here
      expect(page).to have_content("Uploaded on #{user.photos.last.created_at}")
    end
  end

  context 'user already has a photo' do

    before do
      user.photos = create_list(:photo, 1)
      user.save
    end

    scenario 'can see thumbnail of their photo' do
      visit user_photos_path(user.id)
      expect(page).to have_content("Uploaded on #{photo.picture_created_at}")
    end

    scenario 'can see individual photo' do
      visit user_photos_path(user.id)
      expect(click_link "#{photo.picture_file_name}").to have_content("Back to Photos Index")
    end

    context 'photo comments and likes' do
      before :each do
        sign_out

        other_user = create(:user, email: "other@email.com")
        sign_in(other_user)

        visit user_photos_path(user.id)
      end

      scenario "can comment on other user's photo" do
        expect(page).to have_css('textarea[placeholder="Write a comment..."]')

        fill_in :body, with: "witty photo comment"
        expect{click_button "Comment"}.to change(Comment, :count).by(1)
        expect(page).to have_content("witty photo comment")
      end

      scenario "can delete own comment on other user's photo" do
        fill_in :body, with: "witty photo comment"
        click_button "Comment"

        expect{click_link "Delete"}.to change(Photo, :count).by(-1)
        expect(page).to_not have_content("witty photo comment")
      end

      scenario "can like a photo and then unlike same photo" do
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