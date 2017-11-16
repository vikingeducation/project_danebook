module PostsHelper
  def fullname(user)
    "#{user.profile.firstname} #{user.profile.lastname}"
  end
end
