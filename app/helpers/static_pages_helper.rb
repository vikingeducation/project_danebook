module StaticPagesHelper

  #Check that returns attribute without '_confirmation'.
  def confirmation_check(attribute)
    if /confirmation/.match attribute.to_s
      attribute_parts = attribute.to_s.split('_').map(&:to_sym)
      return attribute_parts.first
    else
      attribute
    end
  end

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

end
