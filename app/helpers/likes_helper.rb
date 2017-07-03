module LikesHelper

  def first_few_likes(post)
    # three_likes =
    post.likes.order('created_at').limit(3)
    # three_names = []
    # three_likes.each {|l| l.user_id == current_user.id ? (three_names << "You") : (three_names << full_name(l) ) }
    # three_names
    # three_likes.map {|l| l.user }
    # .pluck(:user_id)
    # ids.map {|id| User.find(id) }
  end


  def three_ids_who_liked(post)
    post.likes.order('created_at').limit(3).pluck(:user_id)
  end

  def number_of_likes(post)
    post.likes.count
  end

  def current_user_liked?(post)
    post.likes.where( :user_id => current_user.id ).any?
  end


end
