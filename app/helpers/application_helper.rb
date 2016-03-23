module ApplicationHelper
  def errors(object,field)
    # No errors if no errors!
    if object.errors[field].empty?
      error = ""
    else
      # Otherwise, create an error <div> around the message
      error = content_tag(:div, :class=>"alert alert-danger") do
        field.to_s.titleize + " " + object.errors[field].first
      end
    end
    # Combine our normal input tag with the error message
    error
  end

  def all_errors(object)
    error = ""
    unless object.errors.any?
      # Otherwise, create an error <div> around the message
      object.errors.each do |e|
        error += content_tag(:div, :class=>"alert alert-danger") do
          object.e
        end
      end
    end
    # Combine our normal input tag with the error message
    error
  end
end
