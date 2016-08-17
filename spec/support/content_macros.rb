module ContentMacros
  def create_user_post(user)
    post = create(:post)
    user.posts << post

    post
  end

  def create_post_comment(post)
    comment = create(:comment)
    post.comments << comment
    post.user.comments << comment
    comment
  end
end
