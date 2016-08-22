module LikesHelper

  def likeable_likes_link(likeable)
    current_like = current_user.likes.where(likeable_id: likeable.id, likeable_type: likeable.class)
    like_count = likeable.likes.count
    if current_like.empty?
      link_to "#{pluralize(like_count, 'like')}", polymorphic_url([likeable, Like], likeable_id: likeable.id, likeable_type: likeable.class), title: "#{likeable.recent_likes} Like this", method: :post, class: "like-this"
    else
      link_to "You and #{ pluralize(like_count-1, 'other') } like this", like_path(current_like[0], likeable_id: likeable.id, likeable_type: likeable.class), title: "#{likeable.recent_likes} Like this",  method: :delete, class: "unlike-this"
    end
  end
end
