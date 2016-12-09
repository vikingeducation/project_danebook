class PostsController < ApplicationController

  def new
  end

  def create
  end

  def index
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
