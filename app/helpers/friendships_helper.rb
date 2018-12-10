module FriendshipsHelper

  def friends?(friender, friendee)
    if Friendship.find_by(friender_id: friender.id, friendee_id: friendee.id) ||
      Friendship.find_by(friender_id: friendee.id, friendee_id: friender.id)
      true
    else
      false
    end
  end

end
