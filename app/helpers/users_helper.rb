module UsersHelper

  def friend_or_unfriend(user)
    friended = user.friended_by?(current_user)
    str = ""
    str += "<h6>You are already friends!</h6>" if friended
    str += link_to  friended ? "Unfriend Me" : "Friend Me!",
                    user_friendings_path(user),
                    method: friended ? :delete : :post,
                    class: friended ? "btn btn-lg btn-default" : "btn btn-lg btn-primary"
    str.html_safe
  end

end
