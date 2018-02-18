module LikesHelper

  def number_of_likes(post)
    post.likes.count
  end

  def current_user_liked?(post)
    post.likes.where( :user_id => current_user.id ).any?
  end

  def few_related_liker_ids(post)
    all_likers_ids = post.likers.ids
    friend_likers_ids = current_user.friended_users.ids
    other_likers_ids = all_likers_ids - friend_likers_ids
    who_liked = all_likers_ids.take_while {|i| friend_likers_ids.include? i}
    who_liked.unshift(current_user.id) if all_likers_ids.include? current_user.id
    while who_liked.size <= 3 && other_likers_ids.size > 1
        who_liked << other_likers_ids.last
        other_likers_ids.pop
    end
    who_liked.first(3)
  end

end
