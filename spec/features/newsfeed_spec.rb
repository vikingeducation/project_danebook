require 'rails_helper'

feature 'user newsfeed' do
  # We've added a new newsfeed feature to the site!

  # When a user logs in, they should should be redirected to their newsfeed.
  before do
    visit root_path
    @user1 = create(:user)
    @user2 = create(:user)
    @new_post = create(:post, author: @user1)
    @new_friend_post = create(:post, author: @user2)

    login_user(previous_user: @user1)
  end

  scenario 'logged in user interacts with their newsfeed' do
    # The user should be redirected to their newsfeed.
    expect(page).to have_css("#newsfeed")

    # The user should be able to see both their post and their friend's post.
    expect(page).to have_content(@new_post.body)
    expect(page).to have_content(@new_friend_post.body)
  end

  scenario 'posting from newsfeed brings them back to newsfeed' do
    fill_in "post[body]", with: "This is a test."
    expect{click_button "Post"}.to change(Post, :count).by(1)

    expect(page).to have_css("#newsfeed")
  end

  scenario 'posting from timeline brings them back to timeline' do
    visit user_posts_path(@user1, newsfeed: "false")
    fill_in "post[body]", with: "This is a test."
    expect{click_button "Post"}.to change(Post, :count).by(1)

    expect(page).to_not have_css("#newsfeed")
  end

end
