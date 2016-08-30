module UsersHelper

  def render_user_panel(user)
    render partial: 'static_pages/user_panel', locals: { user: user }
  end

  def users_count_check(users)
    len = users.length
    len > 5 ? [users[0..4],users[5..len-1]] : [users[0..len-1]]
  end

  def show_address(addressable)
    address = addressable.address
    "#{address.street_address}<br>#{address.city}<br>#{address.state} #{address.zip_code}, #{address.country}<br>".html_safe
  end

  def show_date(date)
    date = date.date_object
    "#{date.month}/#{date.day}/#{date.year}"
  end

end
