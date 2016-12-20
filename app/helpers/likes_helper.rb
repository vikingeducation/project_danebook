module LikesHelper

  def liker_names(likes)
    likes.map { |like| User.find(like.user_id).name }
  end

  def names_like_this(names)
    case names.length
    when 0
      ""
    when 1
      "#{names[0]} likes this"
    when 2
      "#{names[0]} and #{names[1]} like this"
    else
      last = names.pop
      list = names.join(', ')
      "#{list}, and #{last} like this"
    end
  end

  def current_user_likes?(likable)
    !!likable.likes.find_by_user_id(current_user.id)
  end
end
