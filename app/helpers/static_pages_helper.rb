module StaticPagesHelper

  def menu_options_class(action)
    page = content_for(:page).strip
    if action_name == 'about_edit' && action == 'about'
      'btn btn-default menu-option grey-background'
    elsif action.to_s == page
      'btn btn-default menu-option grey-background'
    else
      'btn btn-default menu-option'
    end
  end

  def get_header_path
    signed_in_user? ? 'layouts/loggedin_header' : 'layouts/login_header'
  end

  def construct_like_sentence(likes)
    num = likes.count
    users = likes.map(&:user)
    if num == 1 && likes.first.user == current_user
      'You like this'
    elsif num == 1
      '1 person likes this'
    elsif users.include?(current_user)
      "You and #{num - 1} others like this"
    else
      "#{users.first.profile.name} and #{num} other people like this"
    end
  end

end
