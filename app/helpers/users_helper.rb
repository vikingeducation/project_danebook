module UsersHelper

  def user_link(user)
    if user == current_user
      "You"
    elsif user
      link_to user.name, user
    end
  end
end
