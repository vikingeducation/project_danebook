module LikesHelper

  def like_link(likable, parent=nil)
    return "" unless likable.respond_to?(:likes)
    if user_like = likable.likes.find_by_user_id(current_user.id)
      link_to "Unlike", user_like, method: "Delete", class: "#{likable.class.name}-like-link"
    else
      link_to "Like", likes_path(like: { likable_type: likable.class, likable_id: likable.id }), method: "Post", class: "#{likable.class.name}-like-link"
    end
  end

  def like_sentence(likable)
    return nil unless likable

    sentence = ""

    case likable.likes.size
    when 0
      return nil
    when 1
      sentence << "#{user_link(likable.likers.first)}"
    when 2
      sentence << "#{user_link(likable.likers.first)} and #{user_link(likable.likers.second)}"
    else
      sentence << "#{user_link(likable.likers.first)}, #{user_link(likable.likers.second)} and #{likable.likes.size - 2} other "
      user_string = ((likable.likes.size - 2) > 1) ? "users" : "user"
      sentence << user_string
    end
    sentence << " liked this #{likable.class.to_s.downcase}."

    sentence ? content_tag(:p, sentence.html_safe, class: "like-sentence") : nil
  end

  private

    def like_url(likable)
      if likable.is_a? Comment
        url_for([likable.commentable.user, likable.commentable, likable, :likes])
      else
        url_for([likable.user, likable, :likes])
      end
    end

    def unlike_url(likable, like)
      if likable.is_a? Comment
        url_for([likable.commentable.user, likable.commentable, likable, like])
      else
        url_for([likable.user, likable, like])
      end
    end
end
