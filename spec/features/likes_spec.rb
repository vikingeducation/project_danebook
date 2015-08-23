require 'rails_helper'



feature 'Liking Posts' do

  let(:user) { create(:user) }
  let(:post) { create(:post) }
  # add another post that I don't intend to click on?
  let(:like_post_href) { "/likes?liked_id=#{post.id}&liked_type=Post" }

  before do
    sign_in(user)
  end


  scenario 'Like an unliked Post' do
    visit user_posts_path(post.author)

    click_link 'Like', href: like_post_href

    expect(page.current_path).to eq(user_posts_path(post.author))
    expect(page).to have_content('Liked!')
    expect(page).not_to have_link('Like', href: like_post_href )
    expect(page).to have_link('Unlike', href: like_path(Like.last.id) )
  end


  scenario 'Unlike an already liked Post' do
    post.likers << user
    visit user_posts_path(post.author)

    click_link 'Unlike', href: like_path(Like.last.id)

    expect(page.current_path).to eq(user_posts_path(post.author))
    expect(page).to have_content('Unliked!')
    expect(page).not_to have_link('Unlike')
    expect(page).to have_link('Like', href: like_post_href )
  end

end



feature 'Liking Comments' do

  let(:user) { create(:user) }
  let(:comment) { create(:comment, :on_post) }
  let(:like_comment_href) { "/likes?liked_id=#{comment.id}&liked_type=Comment" }

  before do
    sign_in(user)
  end


  scenario 'Like an unliked comment' do
    visit user_posts_path(comment.commentable.author)

    click_link 'Like', href: like_comment_href

    expect(page.current_path).to eq(user_posts_path(comment.commentable.author))
    expect(page).to have_content('Liked!')
    expect(page).not_to have_link('Like', href: like_comment_href )
    expect(page).to have_link('Unlike', href: like_path(Like.last.id) )
  end


  scenario 'Unlike an already liked comment' do
    comment.likers << user
    visit user_posts_path(comment.commentable.author)

    click_link 'Unlike', href: like_path(Like.last.id)

    expect(page.current_path).to eq(user_posts_path(comment.commentable.author))
    expect(page).to have_content('Unliked!')
    expect(page).not_to have_link('Unlike')
    expect(page).to have_link('Like', href: like_comment_href )
  end

end



feature 'Liking Photos' do

  let(:user) { create(:user) }
  let(:photo) { create(:photo) }
  let(:like_photo_href) { "/likes?liked_id=#{photo.id}&liked_type=Photo" }

  before do
    sign_in(user)
    photo.owner.friended_users << user
  end


  scenario 'Like an unliked photo' do
    visit user_photo_path(photo.owner, photo)

    click_link 'Like', href: like_photo_href

    expect(page.current_path).to eq(user_photo_path(photo.owner, photo))
    expect(page).to have_content('Liked!')
    expect(page).not_to have_link('Like', href: like_photo_href )
    expect(page).to have_link('Unlike', href: like_path(Like.last.id) )
  end


  scenario 'Unlike an already liked photo' do
    photo.likers << user
    visit user_photo_path(photo.owner, photo)

    click_link 'Unlike', href: like_path(Like.last.id)

    expect(page.current_path).to eq(user_photo_path(photo.owner, photo))
    expect(page).to have_content('Unliked!')
    expect(page).not_to have_link('Unlike')
    expect(page).to have_link('Like', href: like_photo_href )
  end

end