class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save!
      flash[:success] = "You have created new comment"
      redirect_to user_timeline_path
    else
      flash[:danger] = "Something went wrong! No post created!"
      redirect_to user_timeline_path
    end
  end

  # def destroy
  #   @post = Post.find(params[:post_id])
  #   @user = current_user
  #   if @post.destroy
  #     flash[:success] = "You have deleted post successfully!"
  #     redirect_to user_timeline_path
  #   else
  #     flash.now[:danger] = "Deleting post didn't work :("
  #     render :index
  #   end
  # end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end

end
