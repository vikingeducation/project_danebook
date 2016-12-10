class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = @user.posts.build

  end

  def edit
  end

  def show
  end

  def destroy
  end

  def update
  end

end
