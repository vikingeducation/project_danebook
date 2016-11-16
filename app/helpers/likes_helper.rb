module LikesHelper


  def num_likes(post)
    post.likes.count
  end

  def current_user_liked(likeable)
    likeable.likes.any?{|l| l.user == current_user}
  end

  def find_like(likeable)
    likeable_type = likeable.class.to_s
    Like.find_by(user: current_user, likeable_id: likeable, likeable_type: likeable_type)
  end

  def likes_display(likeable)
  #check if there are any likes
  if likeable.likes.empty?
    return ""
  end
  #check if current user liked the post
  if current_user_liked(likeable)
    first_like = find_like(likeable)
    first_user = "You"
  else
    first_user = likeable.likes.first.user.profile.full_name
  end
  num_likes = num_likes(likeable)
   if num_likes == 1
    plural = first_user == "You" ? "like" : "likes"
    "#{first_user} #{plural} this"
  elsif num_likes == 2
    second_like = likeable.likes.sample.user
    until second_like != first_like
      second_like = likeable.likes.sample.user
    end
    second_user = second_like.profile.full_name
    "#{first_user} and #{second_user} like this"
  else
    second_like = likeable.likes.sample.user
    until second_like != current_user
      second_like = likeable.likes.sample.user
    end
    second_user = second_like.profile.full_name
    likes_left = num_likes - 2
    plural = likes_left==1 ? "other likes" : "others like"
    "#{first_user}, #{second_user} and #{likes_left} #{plural} this"
  end
end

end
