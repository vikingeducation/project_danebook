module LikesHelper

  def list_likes(resource, user)
    @users = first_user_likes(resource)
    if liked?(resource, user)
      if @users.include?(user.id)
        @users.delete(user.id)
      elsif liked?(resource, user)
        @users.pop
      end
      @users = @users.map { |x| User.find(x).profile.name }
      @users.unshift("You")
      @users.reject(&:blank?)
    else
      @users = @users.map { |x| User.find(x).profile.name }
    end
    if @users.count >= like_count(resource)
      if @users.count == 3
        @users[0].to_s + ", " + @users[1].to_s + " and " + @users[2].to_s + " liked this #{resource.class.to_s.downcase}"
      elsif @users.count == 2
        @users[0].to_s + " and " + @users[1].to_s + " liked this #{resource.class.to_s.downcase}"
      elsif @users.count == 1
        @users[0].to_s + " liked this #{resource.class.to_s.downcase}"
      end
    else
      if @users.count == 3
        @users[0].to_s + ", " + @users[1].to_s + " and " + @users[2].to_s + " and #{like_count(resource) - @users.count} other(s) liked this #{resource.class.to_s.downcase}"
      elsif @users.count == 2
        @users[0].to_s + " and " + @users[1].to_s + " and #{like_count(resource) - @users.count} other(s) liked this #{resource.class.to_s.downcase}"
      elsif @users.count == 1
        @users[0].to_s + " and #{like_count(resource) - @users.count} other(s) liked this #{resource.class.to_s.downcase}"
      end
    end
  end

  def liked?(resource, user)
    if Like.find_by(user_id: user.id, likable_id: resource.id, likable_type: resource.class.to_s)
      true
    else
      false
    end
  end

  def like_count(resource)
    resource.likes.count
  end

  def first_user_likes(resource)
    @users = []
    resource.likes.limit(3).each do |like|
      @users << like.user.id
    end
    @users
  end

end
