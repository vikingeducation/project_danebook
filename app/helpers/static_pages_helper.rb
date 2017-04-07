module StaticPagesHelper
  def body_class
    current_page?(root_url) ? 'class=logged-out' : 'class=logged-in'
  end

  def nav_bar
    current_page?(root_url) ? 'nav_home' : 'nav_logged_in'
  end

end
