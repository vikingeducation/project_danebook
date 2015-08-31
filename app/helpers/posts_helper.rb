module PostsHelper

  def post_index_user_field(label, field)
    unless field.nil? || field.empty?
      "<p>
        <strong>#{label}: </strong>
        #{field}
      </p>".html_safe
    end
  end


  def render_posts(collection, message_if_empty)
    if collection.size == 0
      "<h4 class='text-center text-muted'><em>#{message_if_empty}</em></h4>".html_safe
    else
      render collection
    end
  end


end
