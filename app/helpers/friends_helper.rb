module FriendsHelper

  def link_to_all_friends(user)
    link_to "See more friends!", user_friends_path(user) if user.friends.count > 3
  end

  def add_row_opening(index)
    "<div class = 'row'>".html_safe if index % 3 == 0
  end

  def add_row_closing(index, size)
    "</div>".html_safe if index % 3 == 2 || index == size - 1
  end
end
