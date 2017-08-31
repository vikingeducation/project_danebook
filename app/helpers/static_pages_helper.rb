module StaticPagesHelper

  # would need to change hard coded link when make more dynamic
  def determine_nav
    current_page?('http://localhost:3000/home') ? 'shared/navbar' : 'shared/loggedin_navbar'
  end


  def find_class

  end


end
