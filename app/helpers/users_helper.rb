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

  def user_profile_pic(user, options = {})
    image_tag user.profile_pic ?
              user.profile_pic.data.url(options[:size] || :medium) :
              options[:fallback] || random_user_image,
              class: options[:class] || "img-responsive img-thumbnail"
  end

  def user_currently_lives(user)
    user.profile.current_home ? "Currently Lives in #{user.profile.current_home}" : "No information about their current home"
  end

  def user_hometown(user)
    user.profile.hometown ? "From #{user.profile.hometown}" : "No information about their hometown"
  end

  def user_birthday(user)
    current_user.birthday ? "Born on #{current_user.birthday.to_formatted_s(:long)}" : "No birthday information"
  end

end
