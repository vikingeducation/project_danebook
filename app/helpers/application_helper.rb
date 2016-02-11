module ApplicationHelper


  def field_with_errors(object, field)
    unless object.errors[field].empty?
      content_tag(:div, class: "bg-danger") do
        "#{field.to_s.titleize} #{object.errors[field].first}"
      end
    end
  end





end
