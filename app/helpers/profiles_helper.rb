module ProfilesHelper

  def full_name(post)
    "#{post.user.profile.first_name} #{post.user.profile.last_name}"
  end

  def full_name_of_user(user)
    "#{user.profile.first_name} #{user.profile.last_name}"
  end
end
