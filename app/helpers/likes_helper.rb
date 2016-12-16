module LikesHelper

  def first_few_names(likes)
    return nil if likes.size < 1
    likes.first.initiated_user.first_name
  end

end
