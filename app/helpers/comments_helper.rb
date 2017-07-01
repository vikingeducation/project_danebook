module CommentsHelper

  def full_name(comment)
    "#{comment.user.profile.first_name} #{comment.user.profile.last_name}"
  end

end
