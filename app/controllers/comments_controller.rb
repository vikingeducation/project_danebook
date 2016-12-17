class CommentsController < ApplicationController

  def index
  end

  def create

    @user = User.find(params[:user_id])
    @commentable = extract_commentable
    @comment = @commentable.comments.build(whitelisted_params)
    @comment.commentable_type = find_commentable_type
    @comment.commentable_id = find_commentable_id
    @comment.author_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created"
      redirect_back(fallback_location: proc { user_path(@user) } )
    else
      flash[:error] = @comment.errors.full_messages
      redirect_back(fallback_location: proc { user_path(@user) } )
    end     
  end

  def destroy
    @user = User.find(params[:user_id])
    @commentable = extract_commentable_for_destruction
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment deleted"
      redirect_back(fallback_location: proc { user_path(@user) } )
    end
  end

  private

  def find_commentable_type
    if params[:photo_id]
      "Photo"
    elsif params[:post_id]
      "Post"
    end
  end

  def find_commentable_id
    params[:photo_id] || params[:post_id]
  end

  def whitelisted_params
    params.require(:comment).permit(:body, :user_id, :post_id, :photo_id)
  end

  def extract_commentable
    resource, id = request.path.split('/')[1,2]
    resource.singularize.classify.constantize.find(id)
  end

  def extract_commentable_for_destruction
    resource, id = request.path.split('/')[3,4]
    resource.singularize.classify.constantize.find(id)
  end

end
