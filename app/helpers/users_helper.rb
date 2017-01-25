module UsersHelper

  def full_name(user)
    "#{user.first_name}" + ' ' + "#{user.last_name}"
  end

  def find_user_name(user_id)
    user = User.find(user_id)
    full_name(user)
  end

end
