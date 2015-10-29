module PhotosHelper


  def photo_index(user, photos)
    if photos.empty?
      prompt_for_photos(user)
    else
      render @photos
    end
  end


  def prompt_for_photos(user)
    if user == current_user
      link_to new_user_photo_path(user) do
        "<h4 class='text-muted'><em>Upload a photo to get started!<em></h4>".html_safe
      end
    else
      "<h4 class='text-muted'><em>#{user.profile.first_name} has not uploaded any photos yet.</em></h4>".html_safe
    end
  end

end
