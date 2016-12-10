class PostsController < ApplicationController

  def create
    @user = current_user
    @post = @user.authored_posts.build
    if @post.save
      flash[:success] = "Nice post chum!"
      redirect_to @user
    else
      flash.now[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :id, :author_id)
  end

end
