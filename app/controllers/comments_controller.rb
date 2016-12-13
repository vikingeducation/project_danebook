class CommentsController < ApplicationController

  def index
  end

  def create

    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(whitelisted_params)
    @comment.author_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created"
      redirect_to user_posts_path(@user)
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to user_posts_path(@user)
    end     
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_to user_posts_path
    end
  end

  private

  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

end
