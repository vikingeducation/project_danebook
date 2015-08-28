module PostsHelper

  def post_index_user_field(label, field)
    unless field.nil? || field.empty?
      "<p>
        <strong>#{label}: </strong>
        #{field}
      </p>".html_safe
    end
  end


end
