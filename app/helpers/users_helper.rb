module UsersHelper

  require 'date'

  def user_full_name
    @user.first_name + ' ' + @user.last_name
  end

  def user_birthday
   Date::MONTHNAMES[@user.birth_month] + ' ' + @user.birth_day.ordinalize + ', ' + @user.birth_year.to_s
  end

end
