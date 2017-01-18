class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(commentable_id: params[:id], commentable_type: params[:type], body:comment_params[:body])
    respond_to do |format|
      if @comment.save
        Comment.delay.send_email(@comment.commentable.user.id) if  Rails.env.production?
        format.html{redirect_back(fallback_location: root_path)}
        format.js {}
      else
        flash[:danger] = "Comment was too short" 
        format.html{redirect_back(fallback_location: root_path)}
        format.js{redirect_back(fallback_location: root_path)}
        redirect_back(fallback_location: root_path)
      end
    end
    
  end

  def destroy
    @comment = current_user.comments.where(commentable_id: params[:id], commentable_type: params[:type])

    respond_to do |format|
      unless @comment.empty?
        format.html{redirect_back(fallback_location: root_path)}
        format.js {} 
        @comment.first.destroy
        flash.now[:success] = "Comment destroyed"
      else
        format.html{redirect_back(fallback_location: root_path)}
        format.js{redirect_back(fallback_location: root_path)}
        flash[:danger] = "Unauthorized action"
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end



