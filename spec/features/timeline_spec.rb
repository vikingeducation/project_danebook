

require 'rails_helper'

feature 'Timeline', js: true do
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

    scenario 'existing posts show up' do
      posts = FactoryGirl.create_list(:post, 3, user_id: user.id )
      visit user_timeline_path(user)
      expect(page).to have_css "article.single-post", count: posts.count
    end

    scenario 'user can comment on own posts' do

      FactoryGirl.create(:post, user_id: user.id )
      visit user_timeline_path(user)

      expect(page).not_to have_selector("#comment_body")
      click_link("Comment", match: :first)
      expect(page).to have_selector("#comment_body")

      comment_text = "I think this is just GRAPE!"
      fill_in 'comment_body', with: comment_text
      click_button "Comment"

      expect(page).to have_content(comment_text)
      expect(Comment.count).to eq(1)

      click_link("Delete Comment")
      expect(Comment.count).to eq(0)
      expect(page).not_to have_content comment_text
    end

    scenario 'user can like own posts' do
      FactoryGirl.create(:post, user_id: user.id )
      visit user_timeline_path(user)

      expect(find('article.single-post')).to have_link("Like")
      expect{ find('.Post-like-link').click}.
                              to change(Like, :count).from(0).to(1)

      expect(find('.Post-like-link')).to have_content("Unlike")
      expect{click_link("Unlike")}.to change(Like, :count).from(1).to(0)

    end

    scenario 'user can like own comments' do
      post = FactoryGirl.create(:post, user_id: user.id )
      FactoryGirl.create(:comment,
                         user_id: user.id,
                         commentable_id: post.id,
                         commentable_type: post.class.name)
      visit user_timeline_path(user)

      expect(find('article.comment')).to have_link("Like")
      expect{ find('.Comment-like-link').click}.
                              to change(Like, :count).from(0).to(1)

      expect(find('.Comment-like-link')).to have_content("Unlike")
      expect{click_link("Unlike")}.to change(Like, :count).from(1).to(0)
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
      posts = FactoryGirl.create_list(:post, 3, user_id: other_user.id )
      visit user_timeline_path(other_user)
      expect(page).to have_css "article.single-post", count: posts.count
    end

    scenario 'other users posts can be commented on' do

      FactoryGirl.create(:post, user_id: other_user.id )
      visit user_timeline_path(other_user)

      expect(page).not_to have_selector("#comment_body")
      click_link("Comment", match: :first)
      expect(page).to have_selector("#comment_body")

      comment_text = "I think this is just GRAPE!"
      fill_in 'comment_body', with: comment_text
      click_button "Comment"

      expect(page).to have_content(comment_text)
      expect(Comment.count).to eq(1)

      click_link("Delete Comment")
      expect(Comment.count).to eq(0)
      expect(page).not_to have_content comment_text
    end

    scenario 'other user posts can be liked' do
      FactoryGirl.create(:post, user_id: other_user.id )
      visit user_timeline_path(other_user)

      expect(find('article.single-post')).to have_link("Like")
      expect{ find('.Post-like-link').click}.
                              to change(Like, :count).from(0).to(1)

      expect(find('.Post-like-link')).to have_content("Unlike")
      expect{click_link("Unlike")}.to change(Like, :count).from(1).to(0)

    end

  end


end
