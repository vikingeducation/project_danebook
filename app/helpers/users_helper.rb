module UsersHelper

  def friend_link(user)
    (unless current_user == user
      link_to "Add Friend", friendings_path(user), method: :post
    else
      "<a style='visibility: hidden'><p>test</p></a>"
    end).html_safe
  end

end
