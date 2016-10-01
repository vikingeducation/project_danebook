module LikesHelper

  def first_few_names(likes)
    return nil if likes.count < 1
    likes.first.initiated_user.first_name
  end

end
