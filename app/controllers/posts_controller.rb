class PostsController < ApplicationController
  before_action :require_login, :except => [:show]

  def create
    if signed_in_user?
      current_user
      if @current_user.posts.create(white_listed_posts_params)
        flash[:success] = "Ehhh way to go fonz"
      else
        flash[:error] = "Uh ohhh something went wrong"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end

  def update

  end

  def destroy
    if signed_in_user?
      current_user
      @post = Post.find(params[:id])
      if @post.destroy
        flash[:success] = "You successfully destroyed that post..."
      else
        flash[:error] = "We were unable to destroy the comment, perhaps its gone sentinel...."
      end
      redirect_to :back
    else
      flash[:error] = "You are unauthorized to do this! And I won't stand for it.  You have been temporarily banned....."
      redirect_to login_path
    end
  end

  private

    def white_listed_posts_params
      params.require(:post).permit(:description)
    end
end
