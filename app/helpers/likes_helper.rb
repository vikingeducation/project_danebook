module LikesHelper
  def count_likes(item)
    item.likes.count
  end

  def display_likes(item)
    msg = ""
    if count_likes(item) <= 2 
      item.likes.each do |like|
        msg += "#{user_fullname(like.user)} and "
      end
      msg = msg.gsub(/ and/, "")
    else
      item.likes.each_with_index do |like, k|
        msg += "#{user_fullname(like.user)} and "
        break if k == 1
      end
      i = count_likes(item) - 2
      msg += "#{i} others"
    end
    msg
  end

  def current_user_liked?(item)
    item.likes.where( :user_id => current_user.id ).any?
  end
end

