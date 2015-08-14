require 'rails_helper'

feature 'Like/Comment on a post' do

  let(:user){create(:user)}
  let(:other_user){create(:user)}

  before do
    user.posts = create_list(:post, 1)
    sign_in(other_user)
    visit user_posts_path(user.id)
  end

  context 'liking and unliking a post' do

    #signed in as other_user
    scenario "users can 'like' a post" do

      click_link 'Like'
      #to make sure we're on the right page
      expect(page).to have_content(user.birthdate)

      #check flash msg
      expect(page).to have_content("You have liked this!".upcase)
    end

    scenario "user can 'unlike' something they liked already" do
      click_link 'Like'

      expect(find_link('Unlike').visible?).to be true

      click_link 'Unlike'
      expect(page).to have_content("You have unliked this!".upcase)
    end
  end

  context 'comment on a post' do

    scenario "user can see comment form on post" do
      expect(page).to have_css('input[placeholder="Write a comment..."]')
    end

    scenario 'can create comment on post' do
    fill_in "comment_body", with: "This is a super comment!"

    expect{click_button "Create Comment"}.to change(Comment, :count).by(1)

    expect(page).to have_content("This is a super comment!")
    # save_and_open_page
    # expect(page).to have_content("YOU HAVE COMMENTED!")
  end

  end

  scenario "user can 'like' a comment"



end