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
    # Combine our normal input tag with the error message
    error
  end
end
