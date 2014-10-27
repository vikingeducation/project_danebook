class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build do |comment|
      @comment.commentable_id = @post.id
      @comment.body = params[:body]
      @comment.user = current_user
    end

    if comment.save!
      flash[:success] = "Comment successful"
      redirect_to user_timeline_url(@post.user)
    else
      flash[:error] = "That comment was unsuccesful. Maybe it wasn't a very good comment to begin with?"
      redirect_to user_timeline_url(@post.user)
    end
  end

def destroy
  @comment = Comment.find(params[:comment_id])
  @user = @comment.user

  if @comment.destroy!
    flash[:success] = "Comment destroyed! Your future self thanks you"
    redirect_to user_timeline_url(@user)
  else
    flash[:error] = "Comment couldn't be removed. To be fair, internet content is never really destroyed"
    redirect_to user_timeline_url(@user)
end