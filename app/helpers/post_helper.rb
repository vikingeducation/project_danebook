module PostHelper

  def proper_user(user)
    sign_in_user? && current_user == user
  end
end
