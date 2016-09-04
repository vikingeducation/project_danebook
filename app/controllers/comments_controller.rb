class CommentsController < ApplicationController
  def create
    post = Post.find_by_id(params[:id])
    @comment = post.comments.build(white_list_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = ["Comment create successfully"]
      redirect_to timeline_path
    else
      flash[:danger] = ["Comment is not created"]
      redirect_to timeline_path
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    if comment && comment.destroy
      flash[:success] = ["Comment has been deleted"]
    else
      flash[:danger] = ["Comment can not be found!"]
    end
    redirect_to timeline_path
  end

  def like
    comment = Comment.find_by_id(params[:id])
    like = current_user.likes.build(likeable: comment, like: true)
    if like.save
      flash[:success] = ["Like Counted!"]
    else
      flash[:danger] = ["You already liked this comment"]
    end
    redirect_to :back
  end

  def unlike
    comment = Comment.find_by_id(params[:id])
    like = current_user.likes.find_by(likeable: comment)
    if like && like.destroy
      flash[:success] = ["Unliked Mother fucker!"]
      redirect_to :back
    end
  end

  private
    def white_list_params
      params.require(:comment).permit(:body,
                                      :commentable_id,
                                      :commentable_type)
    end
end
