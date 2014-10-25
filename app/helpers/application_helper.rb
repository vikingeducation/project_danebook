module ApplicationHelper

  def current_user_page(user)
    user != nil && user == current_user
  end
  
end
