module LikesHelper
  def count_likes(post)
    post.likes.count
  end

  def display_likes(post)
    if count_likes(post) <= 2 
      msg = ""
      post.likes.each do |like|
        msg += "#{user_fullname(like.user)} and"
      end
      msg = msg.gsub(/ and/, "")
    else
      msg = ""
      post.likes.each_with_index do |like, k|
        msg += "#{user_fullname(like.user)} and"
        break if i == 1
      end
      i = "#{count_likes(post)}" - 2
      msg += "#{i} others"
    end
    msg
  end

  def current_user_liked?(post)
    post.likes.where( :user_id => current_user.id ).any?
  end
end