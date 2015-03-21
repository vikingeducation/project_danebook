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
      link_to "Edit Profile", edit_user_profile_path(current_user), class: "edit-profile-link"
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



  # returns the proper Twitter Bootstrap classes for various
  # types of flash message
  def flash_class(level)
    case level.to_sym
        when :notice then "alert alert-info"
        when :info then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
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
      link_to "Unfriend User", user_friendings_path(user), method: "delete", class: "btn btn-warning form-control"
    elsif current_user.friends_requested.include?(user)
      link_to "Cancel Request", user_friend_requests_path(user), method: "delete", class: "btn btn-info form-control"
    else
      link_to "Send Friend Request", user_friend_requests_path(user), method: "post", class: "btn btn-primary form-control"
    end
  end


  # COMPLETELY POLYMORPHIC link for liking things
  def like_link(likable, parent = nil)

    # check if this is a thing that can have likes
    return "" unless likable.respond_to?(:likes)

    existing_like = current_user.like_of(likable)

    if existing_like
      link_to "Unlike", unlike_url(likable, existing_like), method: "delete",
                        class: "#{likable.class.name}-like-link"
    else
      link_to "Like", like_url(likable), method: "post",
                      class: "#{likable.class.name}-like-link"
    end

  end

  def delete_comment_link(comment)
    if comment.user == current_user
      link_to "Delete Comment", [comment.commentable.user, comment.commentable, comment], method: "delete", class: "col-sm-1"
    end
  end



  def like_sentence(likable)
    return nil unless likable


    sentence = ""

    case likable.likes.size
    when 0
      return nil
    when 1
      sentence << "#{user_link(likable.users_who_liked.first)}"
    when 2
      sentence << "#{user_link(likable.users_who_liked.first)} and #{user_link(likable.users_who_liked.second)}"
    else
      sentence << "#{user_link(likable.users_who_liked.first)}, #{user_link(likable.users_who_liked.second)} and #{likable.likes.size - 2} other "
      user_string = ((likable.likes.size - 2) > 1) ? "users" : "user"
      sentence << user_string
    end
    sentence << " liked this #{likable.class.to_s.downcase}."

    sentence ? content_tag(:p, sentence.html_safe, class: "like-sentence") : nil
  end


  def user_link(user)
    if user == current_user
      "You"
    elsif user
      link_to user.name, user
    end
  end

  def photo_link(photo)
    return "" unless photo && photo.image_file_name
    user = photo.user
    if user == current_user || user.friends.include?(current_user)
      link_to image_tag(photo.image.url(:thumb)),
              user_photo_path(user, photo), class: "photo-link"
    else
      image_tag photo.image.url(:thumb), class: "photo-link"
    end
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
