require 'rails_helper'
require 'pry'

feature 'Create Comment' do

  let(:post){ create(:post) }
  let(:comment){ build(:comment) }
  before do
    sign_in(post.user)
    visit user_posts_path(post.user)
  end

  context 'User can comment on their own post' do
    before do
    end

    scenario 'A comment form exists under user\'s post' do
      expect(page).to have_selector("form#new_comment")
    end

    scenario 'A comment is created with default attributes' do
      fill_in "comment_body", with: "Test comment"
      expect{click_button "Comment"}.to change(Comment, :count).by(1)
      expect(page).to have_content("Test comment")
    end

    scenario 'A comment can not be created with blank body' do
      fill_in "comment_body", with: " "
      expect{click_button "Comment"}.to change(Comment, :count).by(0)
      expect(page).to have_content("Failed to create comment")
    end
  
  end

end