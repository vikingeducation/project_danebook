module StaticPagesHelper

  #Test that returns attribute without '_confirmation'.
  def confirmation_check(attribute)
    if /confirmation/.match attribute.to_s
      attribute_parts = attribute.to_s.split('_').map(&:to_sym)
      return attribute_parts.first
    else
      attribute
    end
  end

  #Converts attribute to a field.
  def to_field(attribute)
    attribute = confirmation_check attribute
    field = "#{attribute}_field"
    if self.class.method_defined? field
      return field
    else
      return "text_field"
    end
  end

  def make_pages_form(obj,attribute)
    content = obj.send to_field(attribute), 
                       attribute,
                       { class: 'form-control', 
                         placeholder: attribute }
    content_tag :div, content, class: 'form-group'
  end

  def friend_button(user)
    if user.friend?(current_user)
      friend_profile user
    else
      submit_tag "Add Friend", data: { confirm: "Add #{user.full_name} to your friends list?"}
    end
  end

  def friend_profile(user)
    # Needs styling fix.
    link_to button_tag("Friend"), user_path(user)
  end

end
