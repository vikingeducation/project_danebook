module FriendshipsHelper

  def friend_link(friend)
    
    friend = User.find(friend.id)
    friend_profile = friend.profile

    str = link_to("#{friend_profile.first_name} #{friend_profile.last_name}",
                          user_path(friend))
    str.html_safe

  end

  def get_friendship(requestor,receiver)
    friendship = requestor.initiated_friend_requests.where("friend_receiver_id = #{receiver.id}")
    friendship[0]
  end  
end
