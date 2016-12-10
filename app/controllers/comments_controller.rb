class CommentsController < ApplicationController
  before_action :current_user_comment, except: [:like, :unlike, :create]

  def create
    @comment = Comment.new(whitelisted_comments_params)
    if @comment.save
      flash[:success] = "Successfully commented on the post"
      User.delay.send_comment_email(@comment.commentable.user_id)
    else
      flash[:danger] = "Unable to comment on the post"
    end
    redirect_to timeline_user_path(current_user)
  end

  def destroy
    if Comment.find(params[:id]).destroy!
      flash[:success] = "Successfully deleted the comment"
    else
      flash[:danger] = "Unable to delete on the post"
    end
    redirect_to timeline_user_path(current_user)
  end

  def like
    @comment = Comment.find(params[:id])
    unless @comment.likes.pluck(:user_id, :likable_id).include?([current_user.id, @comment.id])
      @comment.likes << Like.new(user_id: current_user.id, likable_type: "Comment")
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  def unlike
    @comment = Comment.find(params[:id])
    if @comment.likes.pluck(:user_id, :likable_id).include?([current_user.id, @comment.id])
      @comment.likes.destroy(@comment.likes.where("user_id = #{current_user.id} AND likable_type = 'Comment'"))
    end
    @profile = current_user.profile
    redirect_to timeline_user_path(current_user)
  end

  private
  def whitelisted_comments_params
    params.require(:comment).permit(:text, :user_id, :commentable_id, :commentable_type)
  end

  def current_user_comment
    unless signed_in_user? && params[:id] && current_user.authored_comment_ids.include?(params[:id].to_i)
      flash[:danger] = "Not authorized!"
      redirect_to timeline_user_path(current_user)
    end
  end

end
