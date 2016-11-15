module ApplicationHelper
  def error_messages_for(object, field=nil)
    errors = field ? object.errors[field] : object.errors.full_messages
    errors.each do |error|
      yield(error)
    end
  end

  def current_user_like_for(likeable)
    Like.where(
      :likeable_id => likeable.id,
      :likeable_type => likeable.class.name,
      :user_id => current_user.id
    ).first
  end

  def user_like_links_for(likeable)
    likeable.likes
      .where('user_id != ?', current_user.id)
      .limit(2)
      .map do |like|
        link_to(like.user.name, user_path(like.user))
      end
  end
end
