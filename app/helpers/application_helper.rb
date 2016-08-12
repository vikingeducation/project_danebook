module ApplicationHelper
  def user_birthday
    @user.birthday.strftime("%B %d, %Y") || @current_user.birthday.strftime("%B %d, %Y")
  end
end
