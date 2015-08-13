module FriendingsHelper

  def friending_status(friend)
    friending = Friending.find_by_friend_id_and_friender_id(current_user, friend)
    if friending.nil?
      return link_to 'Add friend', controller: 'friendings', action: 'create', id: @user.id,
      :confirm => 'Are you sure you want to be friends with #{@user.name}?'
  end
    case friending.status
    when 'pending'
      return 'Pending'
    when 'requested'
      return 'Requested'
    when 'accepted'
      return 'destroy'
    end

  end
end
