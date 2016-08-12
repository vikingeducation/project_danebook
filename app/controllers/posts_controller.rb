class PostsController < ApplicationController
  def create
    current_user
    if @current_user.posts.create(white_listed_posts_params)
      flash[:success] = "Ehhh way to go fonz"
    else
      flash[:error] = "Uh ohhh something went wrong"
    end
    redirect_to root_path
  end

  def update

  end

  def destroy
    current_user
    @post = Post.find(params[:id])
    if current_user.id == @post.user_id
      if @post.destroy
        flash[:success] = "You successfully destroyed that post..."
        redirect_to root_path
      else
        flash[:error] = "We were unable to destroy the comment, perhaps its gone sentinel...."
        redirect_to root_path
      end
    else
      flash[:error] = "You are unauthorized to do this! And I won't stand for it.  You have been temporarily banned....."
      redirect_to logout_path
    end
  end

  private

    def white_listed_posts_params
      params.require(:post).permit(:description)
    end
end
