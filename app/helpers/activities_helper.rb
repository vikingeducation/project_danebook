module ActivitiesHelper
  def feedable_path_for(feedable)
    case feedable.class.name
    when 'Comment'
      user_activity_path(feedable.commentable.user, :anchor => comment_anchor_id_for(feedable))
    when 'Post'
      user_activity_path(feedable.user, :anchor => post_anchor_id_for(feedable))
    when 'Photo'
      user_photo_path(feedable.user, feedable)
    else
      raise "Unknown feedable type"
    end
  end
end
