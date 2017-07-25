module FriendsHelper

  def current_user_friended?(current_user_id, user_id)
    u = Friending.all.where(:friender_id => [current_user.id, user_id])

    u.any? {|u| [current_user.id, user_id].include? u.friend_id }
  end

end
