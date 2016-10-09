require 'rails_helper'

feature 'Comment Features' do

  let(:profile){ create(:profile, :with_attributes ) }
  let(:post){ create(:post) }
  let(:user){ create(:user, profile: profile, posts: [post]) }
  
  
  before do
    sign_in(user)
    click_link "Timeline"
  end

  scenario "entering comment on a post creates new comment" do
    fill_in "Write a comment.", with: "This is a test comment."
    expect{click_button "Comment"}.to change(Comment, :count).by(1)
    expect(page).to have_content("Comment created.")
    expect(page).to have_content("This is a test comment.")
  end

  scenario "submitting blank comment does not create new comment" do
    expect{click_button "Comment"}.to change(Comment, :count).by(0)
  end

  scenario "removing a comment removes the comment" do
    fill_in "Write a comment.", with: "This is a test comment."
    click_button "Comment"
    expect{click_link "Remove Comment"}.to change(Comment, :count).by(-1)
    expect(page).to have_content("Comment deleted")
    expect(page).to_not have_content("This is a test comment.")
  end

end