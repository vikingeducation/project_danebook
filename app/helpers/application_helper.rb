module ApplicationHelper

  def bootstrap_flash_class(type)
    case type
    when 'alert' then 'warning'
    when 'error' then 'danger'
    when 'notice' then 'success'
    else
      'info'
    end
  end

  def button_classes(style = 'primary')
    "btn btn-sm btn-#{style}"
  end

  def table_classes
    "table table-striped table-hover table-sm table-bordered"
  end

  def display_error(object, field)
    unless object.errors.empty?
      content_tag(:span, class: "error-message") do
        "#{object.errors.full_messages_for(field).first}"
      end
    end
  end

end
