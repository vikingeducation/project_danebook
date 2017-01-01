module FriendingsHelper

  def friending_link(user)
    unless current_user == user
      if current_user.friended_users.where(id: user.id).empty?
        button_to "Friend #{user}", friendings_path(friend_id: user.id), method: :post, class: 'btn btn-primary btn-sm'
      else
        button_to "Unfriend #{user}", friending_path(current_user, friend_id: user.id), method: :delete, class: 'btn btn-danger btn-sm'
      end
    end
  end
end
