require 'rails_helper'

feature 'Uploading Photos' do

  # Joe Schmoe wants to upload a file!
  scenario 'user uploads photo to own page' do
    VCR.use_cassette "uploading_1", match_requests_on: [:host, :method] do
      # Joe visits the login page.
      visit root_path

      # He fills out the form with the proper information and logs in.
      login_user

      # Then, after being redirected to his profile, he clicks on the
      # tab that reads 'Photos.'
      first(:link, 'Photos (0)').click

      # Now on a new page, he sees there is a button to begin uploading a file.
      click_link "Upload"

      # On yet another new page (the file upload page), Joe attaches a file.
      attach_file "photo[uploaded_file]", "spec/asset_specs/images/test_photo.jpg"

      # Then, he clicks upload (a different button this time), and is redirected.
      expect{click_button "Upload Photo"}.to change(Photo, :count).by(1)


      # Joe sees his hard work has paid off and he now has 1 photo!
      expect(page).to have_content("Photos (1)")

      # Joe can also see his image now on his photo collection.
      expect(page).to have_css('.photo-page-photo', count: 1)

      # Now, Joe wants to look at his photo, and clicks on it.
      first('.photo-page-photo').click_link("Photo")

      # Joe is redirected to the show page for his image.
      expect(page).to have_content("Set as profile")

      # Joe clicks on his timeline button and sees that his sidebar also
      # only has one photo.
      click_link "Timeline"
      expect(page).to have_content("Photos (1)", count: 2)
      expect(page).to have_css(".col-xs-4", count: 1)
    end
  end


  context 'photo commenting' do
    before do
      VCR.use_cassette "uploading_2", match_requests_on: [:host, :method] do
        # We'll have a few 'constants' being used in these following scenarios.
        @joe_text = "JOE'S TEST POST"
        @jim_text = "Jim's test post"


        # To recap, Joe Schmoe has uploaded a photo.
        # We're just going to mock up what he's created this time.
        visit root_path
        @new_user = login_user
        @new_photo = create(:photo, uploader: @new_user)
        click_link "Sign Out"
      end
    end

    scenario 'user sets new photo to profile photo' do
      # Joe Schmoe is pretty satisfied with his picture, and wants to make
      # it his profile photo.
      login_user(previous_user: @new_user)

      # Joe Schmoe at the moment has no profile photo.
      expect(@new_user.profile_photo).to be_nil

      # He goes back to the picture in question
      first(:link, 'Photos (1)').click
      first('.photo-page-photo').click_link("Photo")

      # He then clicks on the link to set his profile picture
      click_link("Set as profile photo")
      @new_user.reload

      # Now, his profile photo is the new photo
      expect(@new_user.profile_photo).to eq(@new_photo)

      # Then, he signs out
      click_link "Sign Out"
    end

    scenario 'user sets new photo to cover photo' do
      login_user(previous_user: @new_user)

      # Joe Schmoe at the moment has no cover photo.
      expect(@new_user.cover_photo).to be_nil

      # He goes back to the picture in question
      first(:link, 'Photos (1)').click
      first('.photo-page-photo').click_link("Photo")

      # He then clicks on the link to set his cover picture
      click_link("Set as cover photo")
      @new_user.reload

      # Now, his cover photo is the new photo
      expect(@new_user.cover_photo).to eq(@new_photo)

      # Then, he signs out
      click_link "Sign Out"
    end

    scenario 'user commenting/liking own photo' do
      # Let's log in again as Joe Schmoe.
      login_user(previous_user: @new_user)

      # Joe sees that his previously uploaded photo still persists.
      expect(page).to have_content("Photos (1)")

      # Joe clicks on the photos tab.
      click_link("Photos")

      # Joe sees his single photo uploaded, and clicks on it
      first('.photo-page-photo').click_link("Photo")

      # Joe is once again redirected to the show page for his image.
      # Since he's the owner, he also can expect an option to set it
      # as his profile picture.
      expect(page).to have_content("Set as profile")

      # He can additionally see that there is a 'like' link under his name.
      expect(page).to have_content("Like", count: 1)


      # Joe also notices that there is a comment box for him to post a comment.
      expect(page).to have_selector("textarea[placeholder='Write a comment.']")

      # Joe writes a comment, and the clicks the button. A new comment is made.
      fill_in "comment_body", with: @joe_text
      expect{click_button "Comment"}.to change(Comment, :count).by(1)

      # Joe now sees his comment on the page
      expect(page).to have_content(@joe_text)
      # There is also a like link under his photo.
      expect(page).to have_content("Like", count: 2)

      # Pleased that it works, he likes his own photo.
      expect(page).to have_content("Like")
      expect do
        within(".timeline-post-comment") do
          click_link "Like"
        end
      end.to change(Like, :count).by(1)

      # He notices that the link to like a photo is now an 'unlike' button.
      # Additionally, he can see that he likes the photo.
      expect(page).to have_content("Like", count: 1)
      expect(page).to have_content("Unlike")
      expect(page).to have_content("You like this.")
    end

    scenario 'user commenting/liking other photo' do
      # We need to recreate the comment and liking Joe's done for this scenario.
      create(:commented_photo,
              commentable: @new_photo,
              author: @new_user,
              body: @joe_text)

      create(:liked_photo,
              user: @new_user,
              likable: @new_photo)
      # Jim Bob's recently been convinced by Joe Schmoe to sign up to the site.
      # Jim Bob wants to look at Joe Schmoe's new photo, so he logs in.
      visit root_path
      jim_bob_user = login_user

      # Jim Bob then searches for 'Joe'.
      fill_in "name", with: @new_user.first_name
      # This button is off of the page so it can be clicked for this test.
      # Figure out how to click submit_tag elements with type: hidden
      click_on("name")

      # Jim Bob see's Joe Schmoe's name, and clicks on it.
      click_link("#{@new_user.first_name}")

      # Now on Joe Schmoe's page, he sees that Joe has a photo!
      expect(page).to have_content("Photos (1)")

      # Then, Jim looks at Joe's Photo collection.
      first(:link, 'Photos (1)').click

      # On this page, he can see the thumbnail and tries to click it...
      expect(page).to have_css('.photo-page-photo', count: 1)

      # But he's not yet friends with Joe, so he's redirected with a message.
      first('.photo-page-photo').click_link("Photo")

      expect(page).to have_content("You must be friends with this user!")

      # Jim tells Joe to friend him as a user
      create(:friending, user: @new_user, friend: jim_bob_user)

      # Jim also friends him back in return
      create(:friending, user: jim_bob_user, friend: @new_user)

      # Jim tries again to view Joe's photo
      first('.photo-page-photo').click_link("Photo")

      # Now, Jim is on the show page.
      expect(page).to have_content("#{@new_user.full_name}'s Photo")

      # Jim sees Joe's liked his own photo from before. He likes it too.
      expect(page).to have_content(@joe_text)
      expect do
        within(".photo_uploader") do
          click_link "Like"
        end
      end.to change(Like, :count).by(1)

      # He now sees that both he and Joe like the comment.
      expect(page).to have_content("You and #{@new_user.full_name} like this.")

      # He should not see any options to set this photo as a cover/profile pic,
      # nor have the option to delete the photo.
      expect(page).to_not have_content("Delete")
      expect(page).to_not have_content("Set as profile photo")

      # Then, Jim comments on Joe's Photo.

      fill_in "comment_body", with: @jim_text
      expect{click_button "Comment"}.to change(Comment, :count).by(1)

      # Jim now sees his comment on the page, along with Joe's
      expect(page).to have_content(@jim_text)
      expect(page).to have_content(@joe_text)
      # There are two like links, one for Joe's comment, and one for Jim's.
      expect(page).to have_content("Like", count: 2)

      # Jim decides that what he said may be misunderstood,
      # and decides to delete the comment.
      expect{click_link "Delete"}.to change(Comment, :count).by(-1)

      # His comment is removed from the comment list.
      # A message stating that the deletion is successful is shown.
      expect(page).to have_content("Comment successfully deleted!")
      expect(page).not_to have_content(@jim_text)

      # Jim signs out
      click_link "Sign Out"
    end

    scenario 'user deletes photo and associated information' do
      VCR.use_cassette "photo_deletion", match_requests_on: [:host, :method] do
        # We need to re-create the Joe liking from the previous scenario
        # Also, to test deletion, we'll carry over setting the cover/profile photos.
        @new_user.cover_photo = @new_photo
        @new_user.profile_photo = @new_photo

        create(:liked_photo, likable: @new_photo, user: @new_user)

        # Joe has seen Jim's deleted comment and wants to delete his photo anyway.
        login_user(previous_user: @new_user)
        click_link("Photos")
        first('.photo-page-photo').click_link("Photo")

        # For whatever reason, Joe first unlikes his own photo.
        expect{click_link("Unlike")}.to change(Like, :count).by(-1)

        # Joe clicks on the delete link, and then this deletes his photo.
        expect do
          within(".photo-page-photo") do
            click_link ("Delete")
          end
        end.to change(Photo, :count).by(-1)

        # His cover and/or profile photos should now be nil.
        # Todo
        @new_user.reload
        expect(@new_user.cover_photo).to be_nil
        expect(@new_user.profile_photo).to be_nil

        # His account should still exist, though.
        expect(@new_user).to_not be_nil
      end
    end
  end

end
