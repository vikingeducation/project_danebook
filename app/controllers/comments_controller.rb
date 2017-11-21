class CommentsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.order(created_at: :desc)
    @comment = @user.comments.build
  end
  end

  def new
    @comment = current_user.commments.build
  end

  def create
    @comment = current_user.commments.build(commments_params)
    if @comment.save
      redirect_to user_posts_path(@comment.user)
      flash[:success] = "Commented on the item!"
    else
      current_user.commments.build
      flash.now[:error] = "Failed to comment on the item"
      redirect_to user_posts_path(@comment.user)
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    # @comment = Like.all.where(commments_params)[0]
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "Destroyed the comment"
      redirect_to user_posts_path(@comment.user)
    else
      flash[:error] = "Didn't destroy the comment"
      current_user.commments.build
      redirect_to session.delete(:return_to)
    end
  end

  def commments_params
    params.require(:like).permit(:user_id, :body, :commentable_id, :commentable_type)
  end
end
