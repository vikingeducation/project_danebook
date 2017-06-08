class CommentsController < ApplicationController
  before_action :set_post

  def new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created successfully"
      redirect_back(fallback_location: root_path)
    else
      render :new
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.delete
      flash[:success] = "Comment deleted successfully"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
