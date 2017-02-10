module UsersHelper

  def full_name(user)
    "#{user.first_name}" + ' ' + "#{user.last_name}"
  end

  def find_user_name(user_id)
    user = User.find(user_id)
    full_name(user)
  end

  def display_birthday(user)
  "#{user.birth_month}/#{user.birth_date}/#{user.birth_year}"
  end

  def display_college(user)
    user.profile ? "#{user.profile.college}" : 'n/a'
  end

  def display_hometown(user)
    user.profile ? "#{user.profile.hometown}" : 'n/a'
  end

  def display_location(user)
    user.profile ? user.profile.current_location : 'n/a'
  end

  def display_telephone(user)
    user.profile ? user.profile.telephone : 'n/a'
  end

  def display_words(user)
    user.profile ? user.profile.words : 'n/a'
  end

  def display_about_me(user)
  user.profile ? user.profile.about_me : 'n/a'end


end
