

require 'rails_helper'

feature 'Posts', js: true do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    sign_in(user)
    visit user_timeline_path(user)
  end

  scenario "created post shows up on user's own timeline" do
    # verify we're on the user's show page now
    expect(page).to have_selector "h5", text: "Post"

    post_text = "Blah blah blah blah blah blah blah!"
    fill_in "post_body", with: post_text
    click_button "Post"

    expect(page).to have_css('article.single-post p', text: post_text)
  end

  scenario "blank post does not create a post" do
    # verify we're on the user's show page now
    expect(page).to have_selector "h5", text: "Post"
    click_button "Post"

    expect(page).not_to have_css('article.single-post')
  end

  scenario 'existing posts show up on timeline' do
    posts = FactoryGirl.create_list(:post, 4, user_id: user.id )
    visit user_timeline_path(user)
    expect(page).to have_css "article.single-post", count: posts.count
  end



end
