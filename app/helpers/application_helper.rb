module ApplicationHelper

  def post_author(post_id)
    post = Post.find(post_id)
    user = User.find(post.user_id)
  end

end
