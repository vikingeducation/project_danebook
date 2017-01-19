module PostsHelper
  def render_post_comments(post, limit = nil)
    if limit
      comments = post.comments.limit(limit).select{|com| com.user }
    else
      p post.comments
      comments = post.comments.select{|com| com.user }
    end
    if comments.length > 0
      render partial: 'shared/posts/comments', locals: { comments: comments}
    end
  end
end
