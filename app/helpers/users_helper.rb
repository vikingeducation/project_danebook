module UsersHelper

  def from_user(post)
    user = User.find_by_id(post.from)
    user.first_name + " " + user.last_name
  end

end
