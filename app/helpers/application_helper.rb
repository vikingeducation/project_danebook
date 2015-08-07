module ApplicationHelper

  def render_error(resource, field_sym=nil)
    "<small>#{field_sym.to_s.titleize} #{resource.errors[field_sym].first}</small>".html_safe unless resource.errors[field_sym].empty?
  end

end
