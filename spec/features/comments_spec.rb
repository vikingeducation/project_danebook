require 'rails_helper'


feature 'Comment on a Post' do

  let(:user) { create(:user) }
  let(:post) { create(:post) }

  before do
    sign_in(user)
    visit user_posts_path(post.poster)
  end


  scenario 'with valid content length (3..140 characters)' do
    comment_text = "a"*140
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content comment_text
    expect(page).to have_content 'Comment created'
    expect(page.current_path).to eq(user_posts_path(post.poster))
  end


  scenario "with content that's too long (141 characters)" do
    comment_text = "a"*141
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content 'not saved'
    expect(page.current_path).to eq(user_posts_path(post.poster))
  end


  scenario 'with blank content' do
    comment_text = ""
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content 'not saved'
    expect(page.current_path).to eq(user_posts_path(post.poster))
  end


  scenario 'if unauthorized User' do
    sign_out
    visit(user_posts_path(post.poster))

    expect(page).not_to have_button('Comment')
  end

end




feature 'Comment on a Photo' do

  let(:user) { create(:user) }
  let(:photo) { create(:photo) }

  before do
    sign_in(user)
    photo.poster.friended_users << user
    visit user_photo_path(photo.poster, photo)
  end


  scenario 'with valid content length (3..140 characters)' do
    comment_text = "a"*140
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content comment_text
    expect(page).to have_content 'Comment created'
    expect(page.current_path).to eq(user_photo_path(photo.poster, photo))
  end


  scenario "with content that's too long (141 characters)" do
    comment_text = "a"*141
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content 'not saved'
    expect(page.current_path).to eq(user_photo_path(photo.poster, photo))
  end


  scenario 'with blank content' do
    comment_text = ""
    fill_in 'comment_body', with: comment_text
    click_button 'Comment'

    expect(page).to have_content 'not saved'
    expect(page.current_path).to eq(user_photo_path(photo.poster, photo))
  end

end