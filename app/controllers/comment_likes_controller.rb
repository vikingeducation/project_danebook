class CommentLikesController < ApplicationController

  def create
    @timeline = Comment.find(params[:comment_id]).post.user
    @like = current_user.comment_likes.build(comment_id: params[:comment_id].to_i)
    if @like.save
      flash[:success] = "Comment liked"
    else
      flash[:error] = "Comment unliked"
    end
    redirect_to user_profile_path(@timeline)
  end

  def destroy
    @comment = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    if @comment.destroy
      flash[:success] = "Comment deleted"
    else
      flash[:error] = "Couldn't delete the comment"
    end
    redirect_to user_profile_path(@comment.user)
  end

end
