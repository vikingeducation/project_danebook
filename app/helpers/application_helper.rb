module ApplicationHelper
  def render_nav_content
    if signed_in_user?
      render_user_nav
    else
      render_login_nav
    end
  end

  def render_user_nav
    render partial: 'shared/search_bar'
    render partial: 'shared/user_dropdown'
  end

  def render_login_nav
    render partial: 'shared/login_nav'
  end
end
