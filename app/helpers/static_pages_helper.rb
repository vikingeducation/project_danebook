module StaticPagesHelper
  def print_likers(post)
    users = post.likers
    return if users.empty?
    user = post.likers[0]
    user_name = user.first_name + " " + user.last_name
    liked = user_liked?(post)
    if users.count > 1 && liked
      output = "You, #{user_name} and #{users.count} others like this"
    elsif users.count == 1 && liked
      output = "You and #{user_name} others like this"
    elsif users.count > 1
      output = "#{user_name} and #{users.count} others like this"
    elsif users.count == 1
      output = output = "#{user_name} likes this"
    end
  end
end
