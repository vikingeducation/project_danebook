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

      save_and_open_page

      # Joe sees his hard work has paid off and he now has 1 photo!
      expect(page).to have_content("Photos (1)")

      # Joe can also see his image now on his photo collection.
      expect(page).to have_css('.photo-page-photo', count: 1)
    end
  end

end
