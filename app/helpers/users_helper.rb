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
    "#{address.address_1}\n#{address.address_2}\n#{address.city.name}, #{address.state.name}, #{address.country.name}"
  end

  def show_date(dateable)
    date = dateable.profile_date
    "#{date.month}/#{date.day}/#{date.year}"
  end

end
