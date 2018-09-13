module ApplicationHelper


  def display_form_errors(resource, field)
    unless resource.errors[field].empty?
      content_tag(:div, class: "error-msg") do
        "#{field.to_s.titleize} #{resource.errors[field].first}"
      end
    end
  end

  def current_page_user
    User.find(params[:user_id].to_i)
  end

end
