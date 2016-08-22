module ApplicationHelper

  def split_column(content,colwidth=6)
    content_tag :div, content, class: "col-md-#{colwidth}"
  end

end