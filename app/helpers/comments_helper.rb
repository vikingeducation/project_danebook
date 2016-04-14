module CommentsHelper

  def author_name(comment)
    u = User.where(id: comment.user_id)
    return "#{u.first.first_name} #{u.first.last_name}"
  end



  def like_or_unlike(comment)
    # user already likes comment, show "Unlike" button
    if comment.likes.pluck(:user_id).include? current_user.id
      link_to("Unlike", user_comment_like_path(user_id: current_user.id, comment_id: comment.id, id: comment.likes.where(user_id: current_user.id).first.id), method: :delete)
    else
      link_to("Like", user_comment_likes_path(:like => { user_id: current_user.id, likeable_id: comment.id, likeable_type: comment.class.name, comment_id: comment.id }, comment_id: comment.id), method: :post)
    end
  end




end
