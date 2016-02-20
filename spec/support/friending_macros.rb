module FriendingMacros

  def visit_(another_user)
    sign_in(user)
    visit user_path(another_user)
  end
end