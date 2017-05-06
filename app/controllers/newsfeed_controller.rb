class NewsfeedController < ApplicationController

  ### OMG MAKE A NTOE OF THISSS!!!!!!!!!!

  def index
    @user = current_user
    @posts = Post.limit(10).order('created_at DESC').where('user_id IN (?)', @user.friendee_ids).includes(user: [:profile])
    @post = current_user.posts.build
  end
end
