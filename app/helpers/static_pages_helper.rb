module StaticPagesHelper

  def to_field(attribute)
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
