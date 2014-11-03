module ApplicationHelper

  def add_photo_link(user)
    if user == current_user
    link_to "Add Photo!", new_user_photo_path(@user), class: "btn danebook-button"
    else
      "&nbsp".html_safe
    end
  end


  def edit_profile_link(user)
    if current_user_page?(user) && !current_page?(edit_user_profile_url)
      link_to "Edit Profile", edit_user_profile_path(current_user)
    else
      "&nbsp;".html_safe
    end
  end


  def profile_photo(user)
    if user && user.profile_photo && user.profile_photo.image
      image_tag user.profile_photo.image.url(:thumb), class: "profile-photo img-responsive"
    else
      image_tag "user_silhouette_generic.gif", class: "profile-photo img-responsive"
    end
  end

  def cover_image(user)
    if user && user.cover_photo && user.cover_photo.image
      image_tag @user.cover_photo.image.url, class: "hidden-xs hidden-sm"
    else
      image_tag "hogwarts_small.jpg", class: "hidden-xs hidden-sm"
    end
  end

  def readable_date(datetime)
    datetime.to_date.inspect
  end

  # is this page the current_user's?
  def current_user_page?(user)
    user != nil && user == current_user
  end



  # The friend button only shows up on another user’s profile/about pages and Timeline
  # The button changes to “remove friend” after successful friending
  def friend_button(user)
    if user == current_user
      ""
    elsif current_user.has_friend?(user)
      link_to "Remove Friend", user_friendings_path(user), method: "delete", class: "btn danebook-button-grey"
    else
      link_to "Add Friend", user_friendings_path(user), method: "post", class: "btn danebook-button"
    end
  end



  #TODO: remove all of these in refactor
  def like_link(likable)
    if likable.is_a? Comment
      comment_like_link(likable)
    elsif likable.is_a? Post
      post_like_link(likable)
    elsif likable.is_a? Photo
      photo_like_link(likable)
    else
      ""
    end

  end


  def like_button(likable, parent = nil)
    like_object = likable.likes.find_by_liker_id(current_user.id)

    if like_object
      link_to "Unlike", [parent, likable, like_object], method: "DELETE"
    else
      link_to "Like", [parent, likable, :likes], method: "POST"
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
      return "&nbsp".html_safe
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
      "You"
    elsif user
      link_to user.name, user
    end
  end

  def photo_link(photo)
    user = photo.user
    if user == current_user || user.friends.include?(current_user)
      link_to image_tag(photo.image.url(:thumb)), user_photo_path(user, photo), class: "photo-link"
    else
      image_tag photo.image.url(:thumb), class: "photo-link"
    end
  end

private




def photo_like_link(photo)

  if current_user.likes_photo?(photo)
    like = current_user.like_of_photo(photo)
    link_to "Unlike", [photo.user, photo, like], method: "delete", class: "col-md-1"
  else
    link_to "Like", [photo.user, photo, :likes], method: "post", class: "col-md-1"
  end
end

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
