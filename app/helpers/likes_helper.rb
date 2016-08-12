module LikesHelper


  def num_likes(post)
    post.likes.count
  end

  def current_user_liked(post)
    post.likes.any?{|l| l.user == current_user}
  end

  def find_like(post)
    Like.find_by(user: current_user, post: post)
  end

  def likes_display(post)
  #check if current user liked the post
  if post.likes.any?{|l| l.user == current_user}
    first_like = find_like(post)
    first_user = "You"
  else
    first_user = post.likes.first.user.profile.full_name
  end
  num_likes = num_likes(post)
   if num_likes == 1
    plural = first_user == "You" ? "like" : "likes"
    "#{first_user} #{plural} this"
  elsif num_likes == 2
    second_like = post.likes.sample.user
    until second_like != first_like
      second_like = post.likes.sample.user
    end
    second_user = second_like.profile.full_name
    "#{first_user} and #{second_user} like this"
  else
    second_like = post.likes.sample.user
    until second_like != current_user
      second_like = post.likes.sample.user
    end
    second_user = second_like.profile.full_name
    likes_left = num_likes - 2
    plural = likes_left==1 ? "other likes" : "others like"
    "#{first_user}, #{second_user} and #{likes_left} #{plural} this"
  end
end

end
