module StaticPagesHelper

  # would need to change hard coded link when make more dynamic
  def determine_nav
    current_page?(root_path) ? 'shared/navbar' : 'shared/loggedin_navbar'
  end

end
