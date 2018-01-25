module PostsHelper

  def display_post_like_unlike(post)
    if current_user.posts_they_like.include?(post)
      like = Like.current_user_like(post, current_user)
      link_to 'Unlike', user_post_like_path(id: like, post_id: post.id, likeable: 'Post'), method: :delete
    else
      link_to 'Like', user_post_likes_path(post_id: post.id, likeable: 'Post'), method: :post
    end
  end

end
