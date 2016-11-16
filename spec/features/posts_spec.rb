require 'rails_helper'

feature 'creating and deleting posts' do

  before do
    visit root_path
    user = create(:user)
    profile = create(:profile, user: user)
    login(user)
    click_link("Timeline")
  end

  scenario 'logged in user on their own timeline' do
    expect(page).to have_selector('textarea')
    fill_in 'post_body', with: "This is my post"
    expect{ click_button('Post') }.to change(Post,:count).from(0).to(1)
    expect(page).to have_content("This is my post")
    expect(page).to have_content("Delete")
    expect{ click_link('Delete') }.to change(Post, :count).from(1).to(0)
  end

  scenario 'user on another user\'s timeline' do
    user_2 = create(:user)
    profile_2 = create(:profile, user: user_2)
    visit (user_posts_path(user_2))
    expect(page).not_to have_selector('textarea')
    expect(page).to have_content('has no posts yet!')
  end

  scenario 'user seeing another user\'s posts' do
    user_2 = create(:user)
    profile_2 = create(:profile, user: user_2)
    post = create(:post, user: user_2)
    visit (user_posts_path(user_2))
    expect(page).to have_content("This is a post")
    expect(page).to have_content("Like")
    expect(page).to have_content("Comment")
    expect(page).not_to have_content("Delete")
  end

end