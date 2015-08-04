class PostsController < ApplicationController

  def index
    @posts = Post.all
    current_user.posts.build
    @profile = current_user.profile
  end
end
