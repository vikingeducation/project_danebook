class CommentsController < ApplicationController
  before_action :commentable_set_up, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params.merge({commentable_id: @params, commentable_type: params[:commentable]}))
    if @comment.save
      flash[:success] = "Comment posted!"
    else
      flash[:error] = "We couldn't post that comment"
    end
    redirect_to @redirection_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post_author = @comment.commentable.user
    @user = @comment.user
    if is_self?
      if @comment.destroy
        flash[:success] = "Your comment has been deleted"
      else
        flash[:error] = "That comment cannot be deleted"
      end
    else
      flash[:error] = "Sorry, you can't delete that comment"
    end
    redirect_to :back
  end

  private

  def comment_params
    if params[:comment]
      return params.require(:comment).permit(:body)
    end
    {}
  end

  def commentable_set_up
    if params[:commentable] == 'Post'
      @params = params[:post_id]
      @post = Post.find(@params)
      @redirection_path = user_profile_path(@post.user)
    elsif params[:commentable] == 'Photo'
      @params = params[:photo_id]
      @post = Photo.find(@params)
      @redirection_path = photo_path(@post)
    end
  end

end
