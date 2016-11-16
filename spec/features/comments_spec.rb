require 'rails_helper'

feature 'comments' do

  before do
    visit root_path
    user = create(:user)
    profile = create(:profile, user: user)
    login(user)
    user_2 = create(:user)
    profile_2 = create(:profile, user: user_2)
    post = create(:post, user: user_2)
    visit (user_posts_path(user_2))
  end

  scenario 'user comments on a post' do
    fill_in('comment_body', with: "This is a comment")
    expect{ click_button('Comment') }.to change(Comment, :count).from(0).to(1)
    expect(page).to have_content("This is a comment")
    expect(page).to have_content("Delete")
    expect{ click_link('Delete') }.to change(Comment, :count).from(1).to(0)
  end
end