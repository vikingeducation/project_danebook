require 'rails_helper'

feature 'Comment' do
  let(:user){ create(:user) }
  let(:post){ user.text_posts.create(description: "test post") }
  let(:comment){ post.comments.create(description: "test comment", user_id: user.id) }

  before do
    sign_in(user)
  end

  context "signed in user" do
    before do
      make_post_on_own_timeline
      visit user_path(user)
    end

    scenario "will have new comment on existing posts" do
      expect(page).to have_css("form.new_comment")
    end

    scenario "able to comment on existing post" do
      make_comment_on_post
      expect(page).to have_content "comment description"
    end
  end

  context "a signed in user with an existing post" do
    before do
      make_post_on_own_timeline
      make_comment_on_post
    end

    scenario "like a generated comment" do
      within(".like-listing-expanded") do
        click_button "Like"
      end
      expect(page).to have_css ".unlike-class"
    end

    scenario "unlike a liked post" do
      within(".like-listing-expanded") { click_button "Like" }
      within(".like-listing-expanded") { click_button "Unlike" }

      expect(page).to have_css ".like-class"
    end

  end
end
