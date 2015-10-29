module FriendsHelper


  def friend_unfriend_button(friend)
    if friend == current_user
      link_to "(this is you!)", '#', class: "btn btn-block disabled"
    elsif current_user.friended_users.include?(friend)
      link_to "Unfriend", user_friend_path(current_user, friend), method: 'delete', class: "btn btn-danger btn-block", alt: "Unfriend #{friend.profile.full_name}"
    else
      link_to "Friend Me", user_friends_path(current_user, :recipient_id => friend.id), method: 'post', class: "btn btn-primary btn-block", alt: "Add #{friend.profile.full_name} as a Friend"
    end
  end


  def friend_index(user, friends)
    if friends.empty?
      prompt_for_friends(user)
    else
      render :partial => 'friend', :collection => @friends
    end
  end


  def prompt_for_friends(user)
    if user == current_user
      "<h4 class='text-muted'><em>You haven't added any friends yet.<em></h4>".html_safe
    else
      "<h4 class='text-muted'><em>
        #{user.profile.first_name} has not added any friends yet.
      </em></h4>".html_safe
    end
  end

  private

    def get_gender_pronoun(gender)
      if gender == 'Male'
        'him'
      else
        'her'
      end
    end
end
