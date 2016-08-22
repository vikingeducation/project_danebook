class CommentsController < ApplicationController


  def create
    @comment = current_user.comments_written.new(comment_params)
    @object_maker = @comment.user
    if @comment.save!
      if @object_maker != current_user
        User.comment_email(@object_maker.id, current_user.id, @comment.id, params[:commentable_id])
      end
      flash[:success] = "Your comment has been posted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment could not be posted"
      redirect_back(fallback_location: root_path)
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    if current_user.id == @comment.user_id && @comment.destroy!
      flash[:success] = "Your comment has been deleted"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Your comment could not be deleted"
      redirect_back(fallback_location: root_path)
    end

  end


  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end


end
