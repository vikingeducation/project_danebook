module UsersHelper
  def friend_button

    if @current_user == @user
      nil

    elsif @current_user.friended_users.include?(@user)
       link_to "Unfriend", friending_path(Friending.where("friend_id = ?", @user.id).where("friender_id = ?", @current_user.id).first), :method => :delete, class: "btn btn-primary"
    else
       link_to "Friend", friendings_path(friender_id: @current_user.id, friend_id: @user.id), :method => :post, class: "btn btn-primary"
    end


  end

end
