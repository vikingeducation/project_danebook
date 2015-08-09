module PostsHelper


  def like_maker(collection)
    
    if collection.is_a? (Post)
      like =  post_builder(collection)
    else
      like = comment_builder(collection)
    end
    
    return like
  end

  def post_builder(collection)
    count = collection.post_likes.size 
    if count == 1 
      you_like = current_user_post_like(collection)
      return '#{you_like} like this'

    elsif count > 1
      you_like = current_user_post_like(collection)
      return '<span class="grey-text">#{you_like} and </span><span class="grey-text"> and #{count - 1} others like this</span>'.html_safe
    end
    return ""
  end

  def comment_builder(collection)
    count = collection.comment_likes.size 
    if count == 1
      you_like = current_user_comment_like(collection)
      return '<span class="grey-text"> #{you_like}  like this </span>'.html_safe
    elsif count > 1
      you_like = current_user_comment_like(collection)
      '<span class="grey-text">#{you_like} and </span><span class="grey-text"> and #{count - 1} others like this</span>'.html_safe
    end
    return ""
  end  

  def current_user_post_like(collection)
    collection.post_likes.each do |like|
        return "You" if current_user && like.user_id == current_user.id
    end
      return collection.post_likes.first.user
  end

  def current_user_comment_like(collection)
    collection.comment_likes.each do |like|
        return "You" if current_user && like.user_id == current_user.id
    end
      return collection.comment_likes.first.user
  end
end
