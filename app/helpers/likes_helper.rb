module LikesHelper

  def first_few_likes(post)
    post.likes.order('created_at').limit(3)
  end


  def number_of_likes(post)
    post.likes.count
  end

  def current_user_liked?(post)
    post.likes.where( :user_id => current_user.id ).any?
  end


end
