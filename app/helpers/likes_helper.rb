module LikesHelper


  def display_likers(object)
    if object.class.to_s == 'Comment'
      comment_display(object)
    else
      post_display(object)
    end
  end


  private


    def get_liker_names(object)
      names = []
      names << "You" if liked_by_current_user?(object)

      object.likers.first(2).map do |liker|
        names << liker.profile.full_name unless liker == current_user
      end

      names.first(2)
    end


    def liked_by_current_user?(object)
      current_user && object.likers.include?(current_user)
    end


    def conjugate_like(names)
      if names.size == 1 and !names.include?('You')
        'likes'
      else
        'like'
      end
    end


    def post_display(object)
      names = get_liker_names(object)

      name_string = names.join(" and ")
      verb = conjugate_like(names)

      if object.likers.count > 2
        "#{name_string} and #{pluralize(object.likers.count - 2, 'other')} #{verb} this."
      elsif object.likers.count > 0
         "#{name_string} #{verb} this."
      end
    end


    def comment_display(object)
      count = object.likers.count

      if count > 1 && liked_by_current_user?(object)
        "You and #{pluralize(count - 1, 'other')} like this."
      elsif count > 1 && !liked_by_current_user?(object)
        "#{pluralize(count - 1, 'other')} like this."
      end

    end

end
