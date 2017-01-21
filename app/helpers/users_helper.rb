module UsersHelper

  require 'date'

  def user_full_name(user)
    user.first_name + ' ' + user.last_name
  end

  def user_birthday(user)
   Date::MONTHNAMES[user.profile.birth_month] + ' ' + user.profile.birth_day.ordinalize + ', ' + user.profile.birth_year.to_s
  end

end
