require 'rails_helper'

feature "Posting" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:post){ create(:post,user: user )}
  let(:profile2) {create(:profile)}
  let(:user2){ create(:user, profile: profile2) }
  let(:post2){ create(:post,user: user2 )}

  before do
    visit root_url
    sign_in(user)
  end

  context "Navigating from profile" do

    scenario "Posting from own timeline, valid content" do 
      click_link "Timeline"
      fill_in 'post_body', with: "This is a valid post"
      click_button "Post"
      expect(page).to have_content("This is a valid post")
    end
  
    scenario "Posting from post feed, valid content" do
      click_link "Danebook"
      fill_in 'post_body', with: "This is a valid post"
      click_button "Post"
      expect(page).to have_content("This is a valid post")
    end

    scenario "Posting invalid content" do
      click_link "Danebook"
      fill_in 'post_body', with: "No"
      click_button "Post"
      expect(page).to have_content("Post failed!")
    end

    scenario "Deleting own post" do 
      post
      click_link "Danebook"
      expect(page).to have_content(post.body)
      click_link "Delete"
      expect(page).to_not have_content(post.body)
    end
  end

  context "Looking at posts" do
    scenario "Only correct users posts are displayed in timeline" do 
      user
      user2
      post
      post2
      click_link "Timeline"
      expect(page).to have_content(user.last_name)
      expect(page).to_not have_content(user2.last_name)
    end

    scenario "All posts are displayed in the feed"  do
      user
      user2
      post
      post2
      click_link "Danebook"
      expect(page).to have_content(user.last_name)
      expect(page).to have_content(user2.last_name)
    end

    scenario "Can visit other users' timelines" do 
      user
      user2
      post
      post2
      click_link "Danebook"
      click_link user2.first_name
      click_link "User Timeline"
      expect(page).to have_content(user2.last_name)
      expect(page).to_not have_content(user.last_name)
    end
  end


end