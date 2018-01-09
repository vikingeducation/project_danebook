module CommentsHelper

  def display_comment_like_unlike(comment)
    if current_user.comments_they_like.include?(comment)
      like = Like.current_user_like(comment, current_user)
      link_to 'Unlike', user_post_like_path(id: like, post_id: comment.commentable.id, comment_id: comment.id, likeable: 'Comment'), method: :delete
    else
      link_to 'Like', user_post_likes_path(post_id: comment.commentable.id, comment_id: comment.id, likeable: 'Comment'), method: :post
    end
  end

  def display_likes_count(comment)
    comment.likes.count
  end

  def display_users_who_liked(comment)
    comment.likes.map do |like|
      link_to like.user.name, like.user
    end
  end

end
