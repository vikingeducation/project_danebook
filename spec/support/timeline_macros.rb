module TimelineMacros

  def make_post(user)
    # click_link "Timeline"
    fill_in "post_body", with: "Great Post!"
    click_button "Post"
  end

  def make_comment(user)
    make_post(user)
    fill_in "comment_body", with: "Nice Comment!"
    click_button "Comment"
  end

  def like_post(user)
    make_post(user)
    within(".post-like-delete") do
      click_link "Like"
    end
  end
end