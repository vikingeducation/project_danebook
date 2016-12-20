module ApplicationHelper

  def full_name_by_id(user_id)
    profile = User.find(user_id).profile
    "#{profile.first_name} #{profile.last_name}"
  end


end
