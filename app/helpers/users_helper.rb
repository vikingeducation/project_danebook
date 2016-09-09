module UsersHelper
  def friend_button(user)

    if @current_user == user
      nil

    elsif @current_user.friends.include?(user)
      if @current_user.friended_users.include?(user)
        link_to "Unfriend", friending_path(Friending.where("friend_id = ?", user.id).where("friender_id = ?", @current_user.id).first), :method => :delete, class: "btn btn-default"
      else
        link_to "Unfriend", friending_path(Friending.where("friender_id = ?", user.id).where("friend_id = ?", @current_user.id).first), :method => :delete, class: "btn btn-default"
      end
    else
       link_to "Friend", friendings_path(friender_id: @current_user.id, friend_id: user.id), :method => :post, class: "btn btn-primary"
    end


  end

end
