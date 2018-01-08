module PostsHelper

  def display_like_unlike(post)
    if current_user.posts_they_like.include?(post)
      link_to 'Unlike', user_likes_path(post_id: post.id), method: :delete
    else
      link_to 'Like', user_likes_path(post_id: post.id), method: :post
    end
  end

  def display_likes_count(post)
    post.likes.count
  end

  def display_users_who_liked(post)
    post.likes.map do |like|
      link_to like.user.name, like.user
    end
  end

  def display_likes(post)
    if post.has_likes?
      raw("<p class='likes'>Likes: #{display_likes_count(post)} #{display_users_who_liked(post)} </p>")
    end
  end

end
