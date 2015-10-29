module CommentsHelper

  def render_comments(commentable)
    if commentable.comments.count > 0
      render :partial => 'comments/comment', :collection => commentable.comments.order(:created_at)
    end
  end


  def display_comment_date(comment)
    if comment.commentable.is_a?(Photo)
      "<p>Said on #{comment.render_date}</p>".html_safe
    else
      "Said on #{comment.render_date}".html_safe
    end
  end


end
