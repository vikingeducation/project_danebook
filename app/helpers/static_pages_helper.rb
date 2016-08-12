module StaticPagesHelper
  def print_likers(post)
    user_names = post_likers(post)
    return if user_names[0][0].is_a? Fixnum
    name = user_names[0][0].capitalize + " " + user_names[0][1].capitalize
    liker_count = post_likers
    liked = user_liked?(post)
    if liker_count > 1 && liked
      output = "You and #{name} and #{liker_count} others like this"
    elsif liker_count == 1 && liked
      output = "You and #{name} others like this"
    elsif like_count > 1
      output = "#{name} and #{liker_count} others like this"
    elsif like_count == 1
      output = output = "#{name} likes this"
    end
  end
end
