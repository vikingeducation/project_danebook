module ProfilesHelper

  def full_name(post)
    "#{post.user.profile.first_name} #{post.user.profile.last_name}"
  end
end
