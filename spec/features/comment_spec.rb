require 'rails_helper'

feature 'Comment' do
  let(:user){ create(:user) }
  let(:post){ create(:post, user_id: user.id) }
  let(:comment){ create(:comment, user_id: user.id) }

  before do
    sign_in(user)
  end

  context "signed in user" do
    before do
      make_post_on_own_timeline
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

    scenario ""

  end
end
