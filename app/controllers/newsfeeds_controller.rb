class NewsfeedsController < ApplicationController

  def index
    @profile = current_user.profile
    @user = current_user
    @post = @user.posts.build
    @comment = @user.comments.build
    @friend_ids = current_user.friended_users.pluck(:id)
    @friend_ids << current_user.id
    @posts = Post.newsfeed_posts(@friend_ids)
    @post_ids = @posts.pluck(:user_id)
    @recently_active = User.post_authors(@post_ids)
  end

end
