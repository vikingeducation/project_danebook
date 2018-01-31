class ActivityStream

  attr_reader :user, :post, :photo

  def initialize(user_id:)
    @user = User.find(user_id)
    @post = @user.authored_posts.new
    @photo = @user.photos.new
  end

  def activities
    @activities ||= [posts.to_a, photos.to_a].flatten.sort_by { |a| a[:created_at] }.reverse!
  end

  def sidebar_photos
    photos.sample(8)
  end

  def sidebar_friends
    @user.friends.sample(8)
  end

  def recently_active_friends
    recently_active_user_ids = activities.first(30).pluck(:user_id).uniq - [@user.id]
    User.where(id: recently_active_user_ids).includes(:profile_pic)
  end

end
