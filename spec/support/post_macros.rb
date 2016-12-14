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
end
