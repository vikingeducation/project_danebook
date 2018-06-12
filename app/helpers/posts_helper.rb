module PostsHelper

  def birthday(user)
    user.profile.birthday.strftime("%B %d, %Y")
  end

  def college(user)
    user.profile.college
  end

  def hometown(user)
    user.profile.hometown
  end

  def current_town(user)
    user.profile.current_town
  end

  def find_user
    User.find(params[:user_id])
  end

  def user_full_name(post)
    User.find(post[:user_id]).profile.name
  end

  def date_posted(post)
    post.created_at.strftime("%A %m/%d/%Y")
  end

  def list_likes(post, user, type)
    @users = first_user_likes(post)
    if liked?(post,user, type)
      if @users.include?(user.id)
        @users.delete(user.id)
      elsif liked?(post, user, type)
        @users.pop
      end
      @users = @users.map { |x| User.find(x).profile.name }
      @users.unshift("You")
      @users.reject(&:blank?)
    else
      @users = @users.map { |x| User.find(x).profile.name }
    end
    if @users.count >= like_count(post)
      if @users.count == 3
        @users[0].to_s + ", " + @users[1].to_s + " and " + @users[2].to_s + " liked this post"
      elsif @users.count == 2
        @users[0].to_s + " and " + @users[1].to_s + " liked this post"
      elsif @users.count == 1
        @users[0].to_s + " liked this post"
      end
    else
      if @users.count == 3
        @users[0].to_s + ", " + @users[1].to_s + " and " + @users[2].to_s + " and #{like_count(post) - @users.count} other(s) liked this post"
      elsif @users.count == 2
        @users[0].to_s + " and " + @users[1].to_s + " and #{like_count(post) - @users.count} other(s) liked this post"
      elsif @users.count == 1
        @users[0].to_s + " and #{like_count(post) - @users.count} other(s) liked this post"
      end
    end
  end

  def liked?(post, user, type)
    if Like.find_by(user_id: user.id, likable_id: post.id, likable_type: type)
      true
    else
      false
    end
  end

  def like_count(post)
    post.likes.count
  end

  def first_user_likes(post)
    @users = []
    post.likes.limit(3).each do |like|
      @users << like.user.id
    end
    @users
  end


end
