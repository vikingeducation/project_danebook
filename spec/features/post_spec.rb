require 'rails_helper'

feature 'Post' do
  let(:user){ create(:user) }
  let(:post){ create(:post, user_id: user.id) }
  let(:posts){ create_list(:post, 5) }
  let(:user_many_posts){ create(:user){ user.posts= posts } }

  before do
    sign_in(user)
  end

  context "a signed in user" do

    scenario "will have new post form on own timeline" do
      make_post_on_own_timeline
      expect(page).to have_css(".whiteness textarea")
    end

    scenario "will be able to post to own timeline" do
      expect { make_post_on_own_timeline }.to change(user.posts, :count).by(1)
    end

    scenario "cannot make post when not logged in" do
      sign_out
      visit user_timeline_path(user)
      expect(page).not_to have_css("form.new_comment")
    end

    scenario "user can see all posts created on own timeline" do
      sign_out
      sign_in(user_many_posts)
      user_many_posts.posts.each do |post|
        expect(page).to have_content "#{post.description}"
      end
    end
  end
  context "users who wish to delete a post" do
    before do
      make_post_on_own_timeline
    end

    scenario "signed in user can delete a post from timeline" do
      within(".section-footer") do
        click_button "Delete"
      end
      expect(page).not_to have_content "Posted on"
    end

    scenario "user not signed in cannot delete a post from a timeline" do
      sign_out
      visit user_timeline_path(user)

      expect(page).not_to have_css("form.button_to")
    end
  end

  context "users can like posts" do

    let(:liked_post){ create(:like, :liked_post)}
    let(:other_user){ create(:user) }

    scenario "signed in user can like a post on her timeline" do
      make_post_on_own_timeline
      visit user_timeline_path(user)
      click_button "Like"
      expect(page).to have_css ".unlike-class"
    end

    scenario "user can like then unlike a post" do
      make_post_on_own_timeline
      visit user_timeline_path(user)
      click_button "Like"
      expect(page).to have_css ".unlike-class"
      click_button "Unlike"
      expect(page).to have_css ".like-class"
    end
  end
end
