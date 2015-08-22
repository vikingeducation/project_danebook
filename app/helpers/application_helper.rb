module ApplicationHelper

  def render_error(resource, field_sym=nil)
    "<small>#{field_sym.to_s.titleize} #{resource.errors[field_sym].first}</small>".html_safe unless resource.errors[field_sym].empty?
  end

  def user_image(user)
    if user.profile_photo
      user.profile_photo.photo.url(:thumb)
    else
      'user_silhouette_generic.gif'
    end
  end

end
