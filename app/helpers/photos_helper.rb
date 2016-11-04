module PhotosHelper

  def linked_mini_photo(mini_photo, options)
    if current_user.friends_with?(@user) || current_user == @user
      link_to mini_photo, class: options[:html_class] do
        yield
      end
    else
      content_tag(:div, class: options[:html_class]) do
        yield
      end
    end
  end
end
