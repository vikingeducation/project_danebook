module LikesHelper


  def display_likers(object)
    if object.class.to_s == 'Comment'
      display(object, 1)
    else
      display(object, 2)
    end
  end


  def display_like_links(liked_object)
    if signed_in_user?
      if liked_object.likers.include?(current_user)
        link_to 'Unlike', like_path(liked_object.likes.find_by_liker_id(current_user)), method: 'delete', alt: 'Unlike this post'
      else
        link_to 'Like', likes_path(:liked_id => liked_object.id, :liked_type => liked_object.class), method: 'post', alt: 'Like this post'
      end
    end
  end


  private


    def get_liker_names(object, number_of_others)
      names = []
      names << "You" if liked_by_current_user?(object)

      object.likers.first(number_of_others).map do |liker|
        names << liker.profile.full_name unless liker == current_user
      end

      names.first(number_of_others)
    end


    def liked_by_current_user?(object)
      current_user && object.likers.include?(current_user)
    end


    def conjugate_like(number_of_likers)
      if number_of_likers == 1
        'likes'
      else
        'like'
      end
    end


    def display(object, number_of_others)
      names = get_liker_names(object, number_of_others)

      name_string = names.join(" and ")
      verb = conjugate_like(object.likers)

      if object.likers.count > number_of_others
        "#{name_string} and #{pluralize(object.likers.count - number_of_others, 'other person')} #{verb} this."
      elsif object.likers.count > 0
         "#{name_string} #{verb} this."
      end
    end

=begin
    def comment_display(object)
      names = get_liker_names(object, 1)

      name_string = names.join(" and ")
      verb = conjugate_like(names)

      if object.likers.count > 1
        "#{name_string} and #{pluralize(object.likers.count - 1, 'other person')} #{verb} this."
      elsif object.likers.count > 0
         "#{name_string} #{verb} this."
      end
    end
=end

end
