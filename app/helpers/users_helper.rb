module UsersHelper
  def field_with_errors(object,field)

    # No errors if no errors!
    if object.errors[field].empty?
      error = ""
    else
      # Otherwise, create an error <div> around the message
      error = content_tag(:div, :class=>"error") do
        field.to_s.titleize + " " + object.errors[field].first
      end
    end
  end

  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def friend_button(target=@user)
    unless current_user.nil? || is_own_user?(target)
      if can_friend(target)
        return link_to "Friend", friendings_path(id: target.id), method: 'post', class: "btn btn-primary"
      else
        return link_to "Unfriend", friendings_path(id: target.id), method: 'delete', class: "btn btn-default selected"
      end
    end
  end

  def can_friend(target)
    !current_user.friend_ids.include? (target.id)
  end

  def is_own_user?(target)
    current_user.id == target.id
  end

  def display_profile_photo(user)
    if user.profile_photo
      return image_tag user.profile_photo.uploaded_file(:small)
    else
      return image_tag "https://s3.amazonaws.com/basicbucketdkelsey/default.svg"
    end
  end

  def display_cover_photo(user)
    if user.cover_photo
      return image_tag user.cover_photo.uploaded_file
    else
      return image_tag "https://s3.amazonaws.com/basicbucketdkelsey/default_cover.jpg",
       alt: "Image by Sam Hawley: https://www.flickr.com/photos/samhawleywood/8333235080"
    end
  end
end
