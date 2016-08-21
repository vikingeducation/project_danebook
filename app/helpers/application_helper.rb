module ApplicationHelper

  def print_likers(post)
    liker_count = post.likers.count
    users = post.likers.where("user_id != ?", current_user.id)
    liked = user_liked?(post)
    if liked
      liker_count > 1 ? "You, and " + other_liker_draft(users) : "You like this"
    else
      other_liker_draft(users)
    end
  end

  def other_liker_draft(likers)
    liker = likers[0].full_name
    if likers.count > 1
      return "#{liker.capitalize} and #{likers.count - 1} others like this"
    else
      return "#{liker.capitalize} likes this"
    end
  end

  def cover_pic_url(user)
    user.cover_pic ? user.cover_pic.file.url :
                      "http://placehold.it/900x600"
  end

  def profile_pic_url(user)
    user.profile_pic ? user.profile_pic.file.url :
                        "http://placehold.it/150x150"
  end
end
