require 'rails_helper'

feature "Commenting" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:post){ create(:post,user: user )}
  let(:comment){ create(:comment, user: user, commentable: post)}

  before do
    visit root_url
    sign_in(user)
  end

  context "Commenting on post" do

    scenario "Can comment from own timeline, with valid content" do 
      post
      click_link "Timeline"
      fill_in 'Type a comment in here', with: "This is a valid comment"
      click_button "Comment"
      expect(page).to have_content("This is a valid comment")
    end
  
    scenario "Can comment from post feed, with valid content" do
      post
      click_link "Danebook"
      fill_in 'Type a comment in here', with: "This is a valid comment"
      click_button "Comment"
      expect(page).to have_content("This is a valid comment")

    end

    scenario "Can't post invalid content" do
      post
      click_link "Danebook"
      fill_in 'Type a comment in here', with: "Th"
      click_button "Comment"
      expect(page).to have_content("Comment was too short")
    end

    scenario "Can delete own comment" do 

      comment
      click_link "Danebook"
      expect(page).to have_content("this is some comment")
      first('.like-area').click_link('Delete')
      expect(page).to_not have_content("this is some comment")

    end

    scenario "Trying to delete someone elses comment kicks you off" do
      comm = create(:comment)
      expect{visit(comment_path(id: comm.id, method: :delete))}.to raise_error(ActionController::RoutingError)
    end 
  
 
  end


end