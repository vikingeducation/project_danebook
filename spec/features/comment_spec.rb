require 'rails_helper'


feature 'logged in user' do

  let(:user) { build(:user) }

  before do
    user.save
    post = build(:post, user_id: user.id)
    post.save
    comment = build(:comment, user_id: user.id, post_id: post.id)
  end


  scenario "can create a comment on their own post" do
    log_in(user)
    visit user_timeline_path(user)

    comment_body = "This is my comment body"
    find('#comment_body').set(comment_body)
    click_button("Comment")

    expect(page).to have_content("Success! Comment created.")
    expect(page).to have_content(comment_body)
  end


  scenario "can create a comment on another user's post" do
    user2 = create(:user)
    log_in(user2)
    visit user_timeline_path(user)

    comment_body = "This is my comment body"
    find('#comment_body').set(comment_body)
    click_button("Comment")

    expect(page).to have_content("Success! Comment created.")
    expect(page).to have_content(comment_body)
  end


# TODO:
  # scenario "can delete their own comment" do
  #   comment.save
  #   log_in(user)
  #   visit user_timeline_path(user)

  #   comment_body = "This is my comment body"
  #   save_and_open_page
  #   # click_on("Delete")
  #   expect(page).to have_content("Success! comment deleted")
  #   expect(page).to_not have_content(post.body)
  # end


  # scenario "logged in user cannot delete another user's post" do
  #   user2 = create(:user)
  #   create(:post, user_id: user2.id)
  #   post.save
  #   visit user_timeline_path(user2)

  #   expect(page).to_not have_link("Delete", user_post_path(user2.id, post.id))
  # end



end