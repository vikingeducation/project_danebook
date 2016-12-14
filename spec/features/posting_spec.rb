require 'rails_helper'

feature "Posting" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:post){ create(:post,user: user )}

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


end