module ActivitiesHelper

  def like_or_unlike(activity)
    liking = activity.likes.where(:user_id == current_user.id).limit(1).first
    if liking
      link_to "Unlike", liking_path(liking), method: :delete, class: "ex-post-like-link"
    else
      link_to "Like", activity_likings_path(activity), method: :post, class: "ex-post-like-link"
    end
  end

  def display_likes(activity)
    unless activity.likes.empty?
      "<div class='col-xs-12 ex-poster-info'>
        <span class='ex-post-like'>#{display_num_or_people(activity)} this</span>
      </div>".html_safe
    end
  end

  def display_num_or_people(activity)
    count = activity.likes.count
    names = activity.likers.limit(3).each_with_object([]) do |person, obj|
      obj << person.fullname
    end
    if count < 4
      format_names(names)
    else
      "#{names.join(", ")} and #{count - 3} other people like"
    end
  end

  def format_names(arr)
    if arr.length == 3
      arr.insert(-2, "and").join(", ") << " likes"
    elsif arr.length == 2
      arr.insert(-2, "and").join(" ") << " likes"
    else
      "#{arr.first} likes"
    end
  end

end
