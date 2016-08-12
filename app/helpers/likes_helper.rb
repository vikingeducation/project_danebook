module LikesHelper

  def post_likes_link(post)
    current_like = current_user.likes.where(likeable_id: post.id, likeable_type: "Post")
    like_count = post.likes.count
    if current_like.empty?
      link_to "#{pluralize(like_count, 'like')}", post_likes_path(post), title: "#{post.recent_likes} Like this", method: :post
    else
      link_to "You and #{ pluralize(like_count-1, 'other') } like this", like_path(post_id: post.id), title: "#{post.recent_likes} Like this",  method: :delete
    end
  end



end
