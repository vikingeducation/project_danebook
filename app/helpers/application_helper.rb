module ApplicationHelper

  def message_error(resource, field)
    if resource.errors[field].empty?
      error = ''
    else
      error = content_tag(:div, class: "error") do
        field.to_s.titleize + " " + resource.errors[field].first
      end
    end
  end

end
