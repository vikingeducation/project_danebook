module UsersHelper

  def full_name(user)
    user.profile.first_name + " " + user.profile.last_name
  end

end
