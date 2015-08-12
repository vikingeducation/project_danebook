require 'rails_helper'

feature 'Posting' do

  scenario 'user posts to own page and post is created' do
    visit root_path
    login_user
    first(:link, 'Timeline').click
    fill_in "post[body]", with: "This is a test."
    expect{click_button "Post"}.to change(Post, :count).by(1)
    expect(Post.first.body).to eq("This is a test.")
  end

  scenario 'user can delete own post' do
    visit root_path
    login_user
    create(:post, author: User.first)
    first(:link, 'Timeline').click
    expect{click_link "Delete"}.to change(Post, :count).by(-1)
  end

  scenario 'user cannot see delete button for unowned post' do
    visit root_path
    login_user
    create(:post)
    first(:link, 'Timeline').click
    expect{click_link "Delete"}.to raise_error(Capybara::ElementNotFound)
  end
end
