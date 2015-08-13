module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade-in", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat message
      end)
    end
    nil
  end

  def likes_count_message(commentable_type)
    str = ""
    likes = commentable_type.likes
    like_count = likes.count
    if like_count > 3
      likes[0..2].each do |like|
        str += link_to like.user.name, user_path(like.user.id) + ", "
      end
      str += ", and #{like_count-3}" + like_count-3 == 1 ? "other likes" : " others like" + " this"
    elsif like_count <= 0
      str = "Be the first one to like this!"
    else
      likes.each_with_index do |like, index|
        str += link_to like.user.name, user_path(like.user.id)
        str += ", " unless index >= like_count - 2
        str += ", and " if index == like_count - 2
      end
      str += like_count == 1 ? " likes this" : " like this"
    end
    str.html_safe
  end

  def comment_likes_message(commentable)
    likes_count = commentable.likes.count
    case likes_count
    when 0
      "Be the first one to like this #{commentable.class.to_s.downcase}!"
    when 1
      "1 person likes this"
    when (2..Float::INFINITY)
      "#{likes_count} people like this"
    else
      "Huh??? It seems this got a DISlike!"
    end
  end

  def like_or_unlike_button(likeable_type)
    liked = likeable_type.liked_by?(current_user)
    link_to liked ? "Unlike" : "Like",
            like_path(likeable_type: likeable_type.class.to_s,
                      likeable_id: likeable_type.id),
            method: liked ? :delete : :post,
            class: "col-xs-2"
  end

  def friending_button(user)
    friended = user.friended_by?(current_user)
    link_to friended ? "Remove Friend" : "Add as Friend",
            user_friendings_path(user),
            method: friended ? :delete : :post,
            class: friended ? "btn btn-sm btn-default" : "btn btn-sm btn-primary"
  end

  def random_user_image
    ["Hermione-Granger.jpg", "RonWeasley.jpg", "Rubeus_Hagrid.jpg", "Cho-Chang.jpg", "Bonnie-Wright.jpg", "cedric-diggory.jpg", "albus-dumbledore.jpg", "lord-voldemort-smiling.jpg"].sample
  end


end
