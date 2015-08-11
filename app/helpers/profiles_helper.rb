module ProfilesHelper
  def likes_counter(likeable)
    count = likeable.likes.count

    if count == 0
      str = link_to "Be the first to like this.", likes_path(likeable_id: likeable.id, likeable_type: likeable.class), method: :post
    elsif likeable.already_liked_by?(current_user) && count == 1
      str = ""
    elsif likeable.already_liked_by?(current_user) && count == 2
      str = "(You and 1 other like this)."
    elsif likeable.already_liked_by?(current_user) && count > 1
      str = "(You and #{count-1} others like this)."
    else
      str = link_to("Like", likes_path(likeable_id: likeable.id, likeable_type: likeable.class), method: :post)
      str + other_likes(likeable)
    end
  end

  def other_likes(likeable)
    if likeable.likes.count == 1
      str = "<span class='grey-text'>  One other likes this.</span>"
    else
      str = "<span class = 'grey-text'>  #{likeable.likes.count} others like this).</span>"
    end
    str.html_safe
  end

  def like_str(likeable)
    if likeable.already_liked_by?(current_user)
      str = link_to("Unlike ", like_path(current_user_like(likeable)), method: :delete)
    else
      str = ''
    end
    (str + likes_counter(likeable)).html_safe
  end

  def friend_button(user)
    if current_user.friended_users.include?(user)
      return "<a> #{friend_button_text(user)}</a>".html_safe
    else 
      return link_to("#{friend_button_text(user)}", "#{friendings_path(id: @user.id)}" , method: :post)
    end
      str
  end

  def friend_button_text(user)
    return unless current_user
    if current_user == user
      str = ''
    elsif current_user.friends.include?(user)
      str = 'You are friends'
    elsif current_user.friended_users.include?(user) && 
          !current_user.users_friended_by.include?(user)
      str = 'Friend Request Pending'
    elsif !current_user.friended_users.include?(user) && 
          current_user.users_friended_by.include?(user)
      str = "Accept #{user.first_name}'s Friend Request"
    else
      str = "Add #{user.first_name} as a Friend"
    end
    str
  end

  private

  def current_user_like(likeable)
    likeable.likes.where(:user_id => current_user.id).first
  end

end
