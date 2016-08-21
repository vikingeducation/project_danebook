module SearchResultHelper
  def num_friends(user)
    num_friends = user.friends.count
    if num_friends > 2
      "#{num_friends} Friends"
    elsif
      "#{num_friends} Friend"
    else
      nil
    end
  end

  def currently_lives(user)
    unless user.profile.currently_lives.nil?
      "Currently Lives in #{user.profile.currently_lives}"
    end
  end

  def user_hometown(user)
    unless user.profile.hometown.nil?
      "From #{user.profile.hometown}"
    end
  end

  def user_birthday(user)
    unless user.profile.birthday.nil?
      "Born on #{user.profile.birthday}"
    end
  end

  def sr_friend_or_unfriend_button(user)
    if current_user && current_user != user
      if current_user.friends_with?(user)
        sr_unfriend_button(user)
      else
        sr_friend_button(user)
      end
    end
  end

  def sr_friend_button(user)
    content_tag(:div, link_to("Friend", friendings_path(friending: {friendee: user.id}), method: :post, type: 'button', class: 'btn btn-primary ', id: 'sr-friend-button'), id: 'friend-button-container')
  end


  def sr_unfriend_button(user)
    content_tag(:div, link_to("Unfriend", friending_path(user.id), method: :delete, type: 'button', class: 'btn btn-danger col-xs-offset-1', id: 'sr-unfriend-button'), id: 'friend-button-container')
  end

  def num_sr_results(num, params)
    if num == 0
      'We were unable to find any matches :('
    else
      "Showing #{num} users whose first or last names contain \"#{params}\""
    end
  end
end
