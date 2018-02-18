module PostAndCommentMacros

  def have_created_post
    fill_in('post_body', :with => 'Hey, This is my new post!!!')
    click_button "Post"
  end

  def have_created_comment
    fill_in('comment_body', :with => 'Hey, This is my new comment!!!')
    click_button "Comment"
  end

end
