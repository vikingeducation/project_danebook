module ApplicationHelper
  def render_nav_content
    if signed_in_user?
      render_user_nav
    else
      render_login_nav
    end
  end

  def render_user_nav
    render partial: 'shared/navbar/user'
  end

  def render_notice_badge
    " <span class=\"badge\">#{current_user.notice_count}</span>".html_safe if current_user.notice_count > 0
  end

  def render_login_nav
    render partial: 'shared/navbar/anon'
  end

  def format_user_name(user)
     "#{user.profile.first_name} #{user.profile.last_name}"
  end
end
