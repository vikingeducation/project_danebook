require 'rails_helper'
feature "Liking" do
  let(:profile) {create(:profile)}
  let(:user){ create(:user, profile: profile) }
  let(:user_post){ create(:post,user: user )}
  let(:comment){ create(:comment, user: user, commentable: user_post)}
  let(:like){ create(:like, user: user, likeable: user_post)}
  let(:comment_like){ create(:like, user: user, likeable: comment)}

  before do
    visit root_url
    sign_in(user)
  end

  context "Posts" do

    scenario "Liking a post"  do 
      user_post
      click_link "Timeline"
      click_on "Like"
      expect(page).to have_content("Liked!") 
    end
  
    scenario "Unliking a post" do 
      user_post
      like
      click_link "Timeline"
      click_on "Unlike"
      expect(page).to_not have_content("Unlike") 
    end

 
  end

  context "Comments" do

    scenario "Liking a comment" do 
      user_post
      comment
      click_link "Timeline"
      first('.like-area').click_link('Like')
      expect(page).to have_content("Liked!") 
    end
  
    scenario "Unliking a comment" do 
      user_post
      comment
      comment_like
      click_link "Timeline"
      first('.like-area').click_link('Unlike')
      expect(page).to_not have_content("Unlike")
    end

 
  end


end