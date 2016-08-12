module StaticPagesHelper

  def menu_options_class(action)
    if action_name == 'about_edit' && action == 'about'
      'btn btn-default menu-option grey-background'
    elsif action.to_s == action_name
      'btn btn-default menu-option grey-background'
    else
      'btn btn-default menu-option'
    end
  end

  def get_header_path
    action_name == 'home' ? 'layouts/login_header' : 'layouts/loggedin_header'
  end

end
