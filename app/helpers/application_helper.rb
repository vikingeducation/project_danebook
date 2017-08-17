module ApplicationHelper

  def formatted_date(date)
    date.strftime("Posted on %A %d/%m/%Y")
  end

  def list_who_liked(post)
    str = ""
    few_related_liker_ids(post).each do |liker_id|
      if liker_id == current_user.id
        str += "You "
      else
        str += link_to("#{user_full_name(User.find(liker_id))} ", User.find(liker_id), class: "liking")
      end
    end
    str.html_safe
  end

  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end

  def signed_in_user?
    !!current_user
  end

  def full_name(post)
    "#{post.user.profile.first_name} #{post.user.profile.last_name}"
  end

  def user_full_name(user)
    "#{user.profile.first_name} #{user.profile.last_name}"
  end

  def created_at_formatted(model)
    model.created_at.strftime("%A %d/%m/%Y")
  end

  def require_current_user_friends(photo)
    friends = photo.user.friended_users.ids
    friends << photo.user.id
    friends.include? current_user.id
  end


end
