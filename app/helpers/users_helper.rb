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

  def user_currently_lives(user, options = {})
    if user.profile.current_home
      (options[:prepend] || "Currently Lives in") + "#{user.profile.current_home}"
    else
      options[:default] || "No information about their current home"
    end
  end

  def user_hometown(user, options = {})
    if user.profile.hometown
      (options[:prepend] || "From") + "#{user.profile.hometown}"
    else
      options[:default] || "No information about their hometown"
    end
  end

  def user_birthday(user, options = {})
    if current_user.birthday
      (options[:prepend] || "Born on") + "#{current_user.birthday.to_formatted_s(:long)}"
    else
      options[:default] || "No birthday information"
    end
  end

  def user_college(user)
    user.profile.college ? user.profile.college : "No college information"
  end

  def user_mobile(user)
    user.profile.mobile ? user.profile.mobile : "No mobile information"
  end

  def words_to_live_by(user)
    user.profile.summary ? user.profile.summary : "Share some corny quote that makes your ears tingle every time you hear it"
  end

  def about(user)
    user.profile.about ? user.profile.about : "Share how awesome you are with the world!"
  end

  def edit_profile_button(user)
    link_to edit_profile_path do
      '<button class= "btn btn-active", id= "edit-profile">
        Edit Your Profile
      </button>'.html_safe
    end if current_user == user
  end

  def modify_account_button(user)
    link_to "Modify Account", edit_user_path(user), class: "btn btn-warning" if current_user == user
  end

end
