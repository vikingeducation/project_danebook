class CommentsController < ApplicationController

  def create
    if params[:commentable] == 'Post'
      @post = Post.find(params[:post_id])
      @comment = current_user.comments.build(comment_params.merge({commentable_id: params[:post_id], commentable_type: params[:commentable]}))
      if @comment.save
        flash[:success] = "Comment posted!"
      else
        flash[:error] = "We couldn't post that comment"
      end
      redirect_to user_profile_path(@post.user)
    elsif params[:commentable] == 'Photo'
      @photo = Photo.find(params[:photo_id])
      @comment = current_user.comments.build(comment_params.merge({commentable_id: params[:photo_id], commentable_type: params[:commentable]}))
      if @comment.save
        flash[:success] = "Comment posted!"
      else
        flash[:error] = "We couldn't post taht comment"
      end
      redirect_to photo_path(@photo)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post_author = @comment.commentable.user
    @user = @comment.user
    if @comment.commentable_type == 'Post'
      if is_self?
        if @comment.destroy
          flash[:success] = "Your comment has been deleted"
          redirect_to user_profile_path(@comment.user)
        else
          flash[:error] = "Sorry, we couldn't delete that comment"
          render :index
        end
      else
        flash[:error] = "Sorry, you can't delete that comment"
        redirect_to user_profile_path(@post_author)
      end
    elsif @comment.commentable_type == 'Photo'
      if is_self?
        if @comment.destroy
          flash[:success] = "Your comment has been deleted"
        else
          flash[:error] = "Sorry, we couldn't delete that comment"
        end
        redirect_to photo_path(@comment.commentable)
      end

    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
