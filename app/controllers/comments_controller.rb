class CommentsController < ApplicationController
  # def index
  #   @user = User.find(params[:user_id])
  #   @comments = @post.comments.order(created_at: :desc)
  #   @comment = @post.comments.build
  # end

  # def new
    # @comment = @post.comments.build
  # end

  def create
    @comment = Comment.new(comments_params)
    session[:return_to] ||= request.referer
    if @comment.save

      # every time a comment is created that is not the author, send a notification to the post, photo owner as an asynchronous message

      if @comment.user_id != current_user.id
        User.delay.send_notification_email(@user.id)
      end


      redirect_to session.delete(:return_to)
      flash[:success] = "Commented on the item!"
    else
      flash.now[:error] = "Failed to comment on the item"
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = "Destroyed the comment"
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Didn't destroy the comment"
      redirect_to session.delete(:return_to)
    end
  end

  def comments_params
    params.require(:comment).permit(:user_id, :body, :commentable_id, :commentable_type)
  end
end
