module PostsHelper

  def birthday(user)
    user.profile.birthday.strftime("%B %d, %Y")
  end

  def college(user)
    user.profile.college
  end

  def hometown(user)
    user.profile.hometown
  end

  def current_town(user)
    user.profile.current_town
  end

  def find_user
    User.find(params[:user_id])
  end

  def user_full_name(post)
    User.find(post[:user_id]).profile.name
  end

  def date_posted(post)
    post.created_at.strftime("%A %m/%d/%Y")
  end

end
