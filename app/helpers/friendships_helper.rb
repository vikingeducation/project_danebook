module FriendshipsHelper

  def not_yet_friends(user)
    !current_user.friends.where("friend_receiver_id != ?",@user.id)
  end  


  def friend_link(friend)
    
    friend = User.find(friend.id)
    friend_profile = friend.profile

    str = link_to("#{friend_profile.first_name} #{friend_profile.last_name}",
                          user_path(friend))
    str.html_safe

  end
end
