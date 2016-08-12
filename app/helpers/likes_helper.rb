module LikesHelper

  def post_likes_link(post)
    current_like = current_user.likes.where(likeable_id: post.id, likeable_type: "Post")
    like_count = post.likes.count
    if current_like.empty?
      link_to "#{like_count} #{"Likes"}", post_likes_path(post), method: :post
    else
      link_to "#{ pluralize(like_count, 'like')}", like_path(post_id: post.id), method: :delete
    end
  end

end
