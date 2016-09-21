class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def real_likes
    Like.where("likeable_id = ? AND likeable_type = ?", self.id, self.class.name)
  end

  def display_likes
    likes = self.real_likes
    like_total = likes.count
    liker_array = []
    likes[0..2].each do |like|
      liker_array << like.user_id
      like_total -= 1
    end
    if like_total == 1
      return_string = "and 1 other person like this"
    elsif like_total > 1
      return_string = "and #{like_total} others like this"
    elsif liker_array.length == 1
      return_string = "likes this"
    else
      return_string = "like this"
    end
    [liker_array, return_string]
  end

end
