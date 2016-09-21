class CommentsController < ApplicationController


  def create
    @new_comment = current_user.comments_written.new(comment_params)
    if @new_comment.save
      @content_id = comment_params[:commentable_id];
      @content_type = comment_params[:commentable_type];
      if comment_params[:commentable_type] == "Post"
        @object_maker = Post.find(comment_params[:commentable_id]).author
      else
        @object_maker = Photo.find(comment_params[:commentable_id]).user
      end
      if @object_maker != current_user
        User.comment_email(@object_maker.id, current_user.id, @new_comment.id, params[:commentable_id])
      end
      respond_to :js
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
