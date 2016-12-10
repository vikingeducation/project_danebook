class PostsController < ApplicationController

  skip_before_action :require_login, only: [:show, :index]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(whitelisted_params)
    if @post.save
      redirect_to user_timeline_path
    else
      # render :
    end

  end

  def edit
  end

  def show
  end

  def destroy
  end

  def update
  end


  private

    def whitelisted_params
      params.require(:post).permit(:body)
    end

end
