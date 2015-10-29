module ApplicationHelper

  def render_navbar
    if signed_in_user?
      render :partial => 'shared/navbar_user'
    else
      render :partial => 'shared/navbar_guest'
    end
  end


  def render_error(resource, field_sym=nil)
    "<small class='error-message'>#{field_sym.to_s.titleize} #{resource.errors[field_sym].first}</small>".html_safe unless resource.errors[field_sym].empty?
  end


  def user_image(user)
    if user.profile_photo
      user.profile_photo.photo.url(:thumb)
    else
      asset_path 'profile_photo_default.png'
    end
  end


  def cover_image(user)
    if user.cover_photo
      user.cover_photo.photo.url
    else
      asset_path 'cover_photo_default.png'
    end
  end

end
