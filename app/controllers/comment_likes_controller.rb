class CommentLikesController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    @timeline = Comment.find(params[:comment_id]).commentable.user
    @like = current_user.comment_likes.build(comment_id: params[:comment_id].to_i)
    if @like.save
      flash[:success] = "Comment liked"
    else
      flash[:error] = "You can't like that comment"
    end
    if @comment.commentable_type == 'Photo'
      redirect_to photo_path(@comment.commentable_id)
    elsif @comment.commentable_type == 'Post'
      redirect_to user_profile_path(@timeline)
    end
  end

  def destroy
    @like = CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id)
    @comment = @like.comment
    if @like.destroy
      flash[:success] = "Unliked"
    else
      flash[:error] = "You can't unlike that comment"
    end
    if @comment.commentable_type == 'Photo'
      redirect_to photo_path(@comment.commentable_id)
    elsif @comment.commentable_type == 'Post'
      redirect_to user_profile_path(@like.user)
    end

  end
end
