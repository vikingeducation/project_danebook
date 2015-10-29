module NewsfeedsHelper

  def render_recently_active(collection, message_if_empty)
    if collection.size ==0
      "<h5 class='text-center text-muted'><em>#{message_if_empty}</em></h5>".html_safe
    else
      render :partial => 'friend', :collection => collection
    end
  end


end
