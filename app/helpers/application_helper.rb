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
    render partial: 'shared/navbar/user'
  end

  def render_login_nav
    render partial: 'shared/navbar/anon'
  end
end
