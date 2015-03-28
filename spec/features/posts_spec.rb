

require 'rails_helper'

feature 'Posts', js: true do
  let(:user){ FactoryGirl.create(:user) }
  before(:each) do
    sign_in(user)

  end

  context "on own timeline" do
    before(:each) do
      visit user_timeline_path(user)
    end

    scenario "created post shows up" do
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

  context "on another user's timeline" do

    let(:other_user){FactoryGirl.create(:user)}

    before(:each) do
      visit user_timeline_path(other_user)
    end

    scenario "no post creation form shows up" do
      # verify we're on the user's show page now
      expect(page).not_to have_selector "h5", text: "Post"
    end

    scenario "that user's posts show up on timeline" do
      posts = FactoryGirl.create_list(:post, 4, user_id: other_user.id )
      visit user_timeline_path(other_user)
      expect(page).to have_css "article.single-post", count: posts.count
    end

  end


end
