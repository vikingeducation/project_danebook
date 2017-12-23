module FriendingsHelper
   def count_user_friends(user)
    user.users_friended_by.count
  end

  # def count_friends_requested(post)
  #   post.likes.count
  # end

  def display_friends(post)
    if count_likes(post) <= 2 
      msg = ""
      post.likes.each do |like|
        msg += "#{user_fullname(like.user)} and "
      end
      msg = msg.gsub(/ and/, "")
    else
      msg = ""
      post.likes.each_with_index do |like, k|
        msg += "#{user_fullname(like.user)} and "
        break if k == 1
      end
      i = count_likes(post) - 2
      msg += "#{i} others"
    end
    msg
  end

  def current_user_liked?(item)
    item.likes.where( :friend_id => current_user.id ).any?
  end
end
