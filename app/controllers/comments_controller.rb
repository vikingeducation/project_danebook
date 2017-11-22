class CommentsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @comments = @user.comments.order(created_at: :desc)

    # Need to build the comments from a user
    @comment = @user.comments.build
    # @comment = @post
  end

  def new
    @comment = current_user.post.comments.build
  end

  def create
    @comment = current_user.comments.build(comments_params)
    binding.pry

    if @comment.save
      redirect_to user_posts_path(current_user)
      flash[:success] = "Commented on the item!"
    else
      current_user.comments.build
      flash.now[:error] = "Failed to comment on the item"
      redirect_to user_posts_path(current_user)
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
      current_user.comments.build
      redirect_to session.delete(:return_to)
    end
  end

  def comments_params
    params.require(:comment).permit(:user_id, :body, :commentable_id, :commentable_type)
  end
end
