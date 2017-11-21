module ApplicationHelper
  def user_fullname(user)
     "#{user.profile.firstname} #{user.profile.lastname}"
   end

  def post_user_fullname(post)
    "#{post.user.profile.firstname} #{post.user.profile.lastname}"
  end

  def comment_user_fullname(comment)
    "#{comment.user.profile.firstname} #{comment.user.profile.lastname}"
  end
end
