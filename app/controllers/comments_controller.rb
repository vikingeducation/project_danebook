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
  end

  private

  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :post_id)
  end

end
