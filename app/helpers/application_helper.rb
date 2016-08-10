module ApplicationHelper

  def split_column(content)
    content_tag :div, content, class: 'col-md-6'
  end

end