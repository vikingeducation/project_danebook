module FriendshipsHelper
  def add_or_remove_friend_button(user)
    if current_user.friended_user_ids.include?(user.id)
      button = "<%= link_to 'Remove Friend', user_friendships_path(@user), method: :post, class: 'btn btn-success pull-right' %>"
    else
      button = "<%= link_to 'Add Friend', user_friendships_path(@user), method: :post, class: 'btn btn-success pull-right' %>"
    end

    button.html_safe
  end

  def friend_count
    @user.friended_users.count
  end
end
