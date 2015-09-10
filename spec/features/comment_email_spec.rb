require 'rails_helper'

feature 'email sent when commenting on commentable' do
  ActionMailer::Base.delivery_method = :test
  context 'email after commenting on photo' do
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
        click_link("Sign Out", match: :first)
      end
    end


    it 'should send an email if someone comments on your photo' do
      # Jim navigates to Joe's Photo and clicks on it.

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

      create(:friending, user: @new_user, friend: jim_bob_user)
      create(:friending, user: jim_bob_user, friend: @new_user)

      visit user_photo_path(user_id:@new_user.id, id: @new_photo.id)

      # Then, Jim comments on Joe's Photo.
      fill_in "comment_body", with: @jim_text

      # Click the button and expect an email to be sent.
      expect{click_button "Comment"}.to change(Delayed::Job, :count).by(1)

    end

    it 'should not send an email if a user comments on his/her own photo' do
      # We need to recreate the comment and liking Joe's done for this scenario.
      create(:commented_photo,
              commentable: @new_photo,
              author: @new_user,
              body: @joe_text)

      create(:liked_photo,
              user: @new_user,
              likable: @new_photo)

      # Joe wants to comment on his own photo.
      visit root_path
      login_user(previous_user: @new_user)

      visit user_photo_path(user_id:@new_user.id, id: @new_photo.id)

      # Joe predictably does not get an email.
      fill_in "comment_body", with: @joe_text
      expect{click_button "Comment"}.to change(Delayed::Job, :count).by(0)
    end
  end
end
