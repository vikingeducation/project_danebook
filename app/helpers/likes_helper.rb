module LikesHelper

  def post_likes_link(post)
    current_like = current_user.likes.where(likeable_id: post.id, likeable_type: "Post")
    like_count = post.likes.count
    if current_like.empty?
      link_to "#{pluralize(like_count, 'like')}", post_likes_path(post, likeable_id: post.id, likeable_type: "Post"), title: "#{post.recent_likes} Like this", method: :post
    else
      link_to "You and #{ pluralize(like_count-1, 'other') } like this", like_path(likeable_id: post.id, likeable_type: "Post"), title: "#{post.recent_likes} Like this",  method: :delete
    end
  end

  
# REFACTOR!!!
  def comment_likes_link(comment)
    current_like = current_user.likes.where(likeable_id: comment.id, likeable_type: "Comment")
    like_count = comment.likes.count
    if current_like.empty?
      link_to "#{pluralize(like_count, 'like')}", comment_likes_path(comment, likeable_id: comment.id, likeable_type: "Comment"), title: "#{comment.recent_likes} Like this", method: :comment
    else
      link_to "You and #{ pluralize(like_count-1, 'other') } like this", like_path(likeable_id: comment.id, likeable_type: "Comment"), title: "#{comment.recent_likes} Like this",  method: :delete
    end
  end

end
