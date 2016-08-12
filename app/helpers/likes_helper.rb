module LikesHelper

  def post_likes_link(post)
    current_like = current_user.likes.where(likeable_id: post.id, likeable_type: "Post")
    if current_like.empty?
      link_to "#{post.likes.count} #{"Likes"}", post_likes_path(post), method: :post
    else
      link_to "You and #{post.likes.count} #{'Others Like This'}", like_path(post_id: post.id), method: :delete
    end
  end

end
