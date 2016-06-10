module UsersHelper
  def user_column(content)
    content_tag :div, content, class: 'col-md-6'
  end

  def render_user_panel(user)
    render partial: 'static_pages/user_panel', locals: { user: user }
  end

  def users_count_check(users)
    len = users.length
    len > 5 ? [users[0..4],users[5..len-1]] : [users[0..len-1]]
  end

end
