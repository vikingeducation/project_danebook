class PostsController < ApplicationController
  before_action :require_login, :except => [:show]

  def create
    if signed_in_user?

      @user = current_user
      @post =@user.text_posts.create(white_listed_posts_params)
      # sdlkfj;
      if @post.id.nil?
        flash[:danger] = "Uh ohhh something went wrong"
      else
        flash[:success] = "Ehhh way to go fonz"
      end
      redirect_to :back
    else
      flash[:danger] = "Please sign in"
      redirect_to login_path
    end
  end

  def update

  end

  def destroy
    if signed_in_user?
      current_user
      if @post = get_instance(params[:id], Post)
        if @post.destroy
          flash[:success] = "You successfully destroyed that post..."
        else
          flash[:danger] = "We were unable to destroy the comment, perhaps its gone sentinel...."
        end
      else
        flash[:danger] = "record not found"
      end
      redirect_to :back
    else
      flash[:danger] = "You are unauthorized to do this! And I won't stand for it.  You have been temporarily banned....."
      redirect_to login_path
    end
  end

  private

    def white_listed_posts_params
      params.require(:post).permit(:description)
    end
end
