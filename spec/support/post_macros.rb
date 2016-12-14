module PostMacros
  def create_post_by(user)
    log_in(user)
    click_link "Timeline"
    fill_in "post_body", with: "Test post"
    click_button('Post')
  end

  def comment_from(user)
    create_post_by(user)
    fill_in "comment_body", with: "First comment"
    find_button("Comment").click
  end

  def crosscomment(commenting_user, target_user)
    create_post_by(target_user)
    log_in(commenting_user)
    visit user_posts_path(target_user)
    # save_and_open_page
    fill_in "comment_body", with: "#{commenting_user.name} commenting on #{target_user.name}'s post'"
    click_button('Comment')
  end
end
