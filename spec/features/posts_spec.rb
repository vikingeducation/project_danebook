require 'rails_helper'


feature 'Make a new Post' do

  let(:user) { create(:user) }

  before do
    create(:full_profile, user: user)
    sign_in(user)
    visit(user_posts_path(user))
  end


  scenario "with valid length (255 characters)" do
    post_text = "a"*255
    fill_in 'post_body', with: post_text
    click_button 'Post'


    expect(page).to have_content post_text
    expect(page).to have_content 'New post created'
    expect(page.current_path).to eq(user_posts_path(user))
  end


  scenario "with content that's too long (256 characters)" do
    post_text = "a"*256
    fill_in 'post_body', with: post_text
    click_button 'Post'

    expect(page).to have_content 'post not saved'
    expect(page.current_path).to eq(user_posts_path(user))
  end


  scenario "with blank content" do
    post_text = ""
    fill_in 'post_body', with: post_text
    click_button 'Post'

    expect(page).to have_content 'post not saved'
    expect(page.current_path).to eq(user_posts_path(user))
  end


  scenario "as an unauthorized User" do
    other_user = create(:user)
    visit(user_posts_path(other_user))

    expect(page).not_to have_button('Post')
  end

end