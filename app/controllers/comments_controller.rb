class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params.merge({post_id: params[:post_id]}))
    if @comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:error] = "We couldn't post that comment"
    end
    redirect_to user_profile_path(@post.user)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post_author = @comment.post.user
    @user = @comment.user
    if is_self?
      if @comment.destroy
        flash[:success] = "Your post has been deleted"
        redirect_to user_profile_path(@comment.user)
      else
        flash[:error] = "Sorry, we couldn't delete that comment"
        render :index
      end
    else
      flash[:error] = "Sorry, you can't do that"
      redirect_to user_profile_path(@post_author)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
