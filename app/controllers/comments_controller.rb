class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    # @comment = Comment.new( 
    #       description: params[:comment][:description],
    #       commentable_type: params[:commentable],
    #       commentable_id: params[:post_id], 
    #       user_id: current_user.id)

    @comment = @post.comments.build(whitelisted_comment_params);
    @comment.user_id = current_user.id;

    if @comment.save
      flash[:success] = "Comment Successfully created!"

      respond_to do |format|
        # format.html { render(:text => "not implemented") }
        format.js { }
      end
    else

      flash[:notice] = "Comment NOT! Sucessfully created!"
    end
  end

  def update
    
  end

  def destroy
    raise
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:success] = "Comment Successfully Deleted!"
      respond_to do |format|
        # format.html { render(:text => "not implemented") }
        format.js { }
      end
    end
    redirect_to current_user
  end

  private
    def whitelisted_comment_params
      params.require(:comment).
        permit( :description)
    end

  #implemented
  # def get_commentable_resource
  #  resource = Post.find(params[:post_id]) if params[:post_id]
  #  resource = Comment.find(params[:comment_id]) if params[:comment_id]
  #  resource = Photo.find(params[:photo_id]) if params[:photo_id]
  #  resource
  # end
end
