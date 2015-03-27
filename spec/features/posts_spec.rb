

require 'rails_helper'

feature 'Posts', js: true do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    sign_in(user)
  end

  scenario "creating a post on user's own timeline" do
    # verify we're on the user's show page now
    visit user_timeline_path(user)
    expect(page).to have_selector "h5", text: "Post"

    post_text = "Blah blah blah blah blah blah blah!"
    fill_in "post_body", with: post_text
    click_button "Post"
    expect(page).to have_css('p', text: post_text)
  end

end
