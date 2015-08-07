module ApplicationHelper

  def render_error(resource, field_sym=nil)
    "<small>#{field_sym.to_s.titleize} #{resource.errors[field_sym].first}</small>".html_safe unless resource.errors[field_sym].empty?
  end


  def direct_navtabs(label, user_id)
    case label
      when 'Timeline' then user_posts_path(user_id)
      when 'About' then user_path(user_id)
      else '#'
    end

  end

end
