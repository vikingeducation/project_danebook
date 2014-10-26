module ApplicationHelper

  # is this page the current_user's?
  def current_user_page?(user)
    user != nil && user == current_user
  end

  def like_link(likable)
    if likable.is_a? Comment
      comment_like_link(likable)
    elsif likable.is_a? Post
      post_like_link(likable)
    else
      ""
    end
  end

  def delete_comment_link(comment)
    if comment.user == current_user
      link_to "Delete Comment", [comment.commentable.user, comment.commentable, comment], method: "delete", class: "col-md-1"
    end
  end



  def like_sentence(likable)
    return nil unless likable
    sentence = ""

    case likable.likes.size
    when 0
      return ""
    when 1
      sentence << "#{user_link(likable.users_who_liked.first)}".html_safe
    when 2
      sentence << "#{user_link(likable.users_who_liked.first)} and #{user_link(likable.users_who_liked.second)}".html_safe
    else
      sentence << "#{user_link(likable.users_who_liked.first)}, #{user_link(likable.users_who_liked.second)} and #{likable.likes.size - 2} other ".html_safe
      user_string = ((likable.likes.size - 2) > 1) ? "users" : "user"
      sentence << user_string
    end
    sentence << " liked this #{likable.class.to_s.downcase}."
  end

  def user_link(user)
    if user == current_user
      "you"
    elsif user
      link_to user.name, user
    end
  end

private


def post_like_link(post)

  if current_user.likes_post?(post)
    like = current_user.like_of_post(post)
    link_to "Unlike", [post.user, post, like], method: "delete", class: "col-md-1"
  else
    link_to "Like", [post.user, post, :likes], method: "post", class: "col-md-1"
  end
end

def comment_like_link(comment)
  if current_user.likes_comment?(comment)
    like = current_user.like_of_comment(comment)
    link_to "Unlike", [comment.commentable.user, comment.commentable, comment, like], method: "delete", class: "col-md-1"
  else
    link_to "Like", [comment.commentable.user, comment.commentable, comment, :likes], method: "post", class: "col-md-1"
  end
end

end
