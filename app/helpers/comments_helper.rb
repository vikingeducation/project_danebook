module CommentsHelper

  def display_comment_like_unlike(comment)
    like = Like.current_user_like(comment, current_user)

    if current_user.comments_they_like.include?(comment)
      link_to 'Unlike', user_like_path(id: like, comment_id: comment.id), method: :delete
    else
      link_to 'Like', user_likes_path(comment_id: comment.id), method: :post
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
