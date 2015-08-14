class CommentsController < ApplicationController
  before_filter :store_referer
  

  def create
    
      @comment = Comment.new(whitelisted_comment_params)
      @comment.user_id = current_user.id
 
    #Check that db does have the object user is tring to comment on
    if @comment.save && @comment.commenting_id && @comment.commenting_type
      flash[:success] = "Comment saved."
    else
      flash[:notice] = "Comment wasn't saved."
    end
    redirect_to referer
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to referer
  end

  private

  


    def whitelisted_comment_params
      #User_id excluded from permited params for safety reason
      params.require(:comment).permit( :commenting_id, :commenting_type, :body)
    end
end
