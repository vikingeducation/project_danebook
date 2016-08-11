module UsersHelper

  def user_birthday
    @current_user.birthday.strftime("%B %d, %Y")
  end

end
