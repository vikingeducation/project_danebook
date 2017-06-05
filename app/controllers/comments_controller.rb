class CommentsController < ApplicationController
  before_action :commentable_set_up, only: [:create]

  def create
    @comment = current_user.comments.build(comment_params.merge({commentable_id: @params, commentable_type: params[:commentable]}))
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to @redirection_path
          flash[:success] = "Comment posted!"
        end
        format.js
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = "We couldn't post that comment"
          redirect_to @redirection_path
        end
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post_author = @comment.commentable.user
    @user = @comment.user
    if is_self?
      if @comment.destroy
        respond_to do |format|
          format.html do
            redirect_to :back
            flash[:success] = "Your comment has been deleted"
          end
          format.js
        end
      else
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
        flash[:error] = "That comment cannot be deleted"
      end
      # if trying to delete someone else's comment:
    else
      flash[:error] = "Sorry, you can't delete that comment"
      respond_to do |format|
        format.html { redirect_to :back}
        format.js
      end
    end
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
