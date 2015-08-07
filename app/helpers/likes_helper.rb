module LikesHelper


  def display_likers(post)
    names = get_liker_names(post)

    name_string = names.join(" and ")
    verb = conjugate_like(names)

    if post.likers.count > 2
      "#{name_string} and #{pluralize(post.likers.count - 2, 'other')} #{verb} this."
    elsif post.likers.count > 0
       "#{name_string} #{verb} this."
    end

  end


  private


    def get_liker_names(post)
      names = []
      names << "You" if liked_by_current_user?(post)

      post.likers.first(2).map do |liker|
        names << liker.profile.full_name unless liker == current_user
      end

      names.first(2)
    end


    def liked_by_current_user?(post)
      current_user && post.likers.include?(current_user)
    end


    def conjugate_like(names)
      if names.size == 1 and !names.include?('You')
        'likes'
      else
        'like'
      end
    end

end
