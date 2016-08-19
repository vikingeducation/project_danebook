module ApplicationHelper

  def errors(obj)
    if obj
      obj.errors.full_messages.each do |msg|
        msg
      end
    end
  end

end
