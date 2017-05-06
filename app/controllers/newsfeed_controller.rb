class NewsfeedController < ApplicationController

  def index
    @user = current_user
    @posts = Post.limit(10).order('created_at DESC').where('user_id IN (?)', @user.friendee_ids.clone << @user.id).includes(user: [:profile])
    @post = current_user.posts.build
    @feed = @posts.where('user_id != ?', @user.id)
  end
end
