class CommentsController < ApplicationController
  def create
    session[:return_to] = request.referer
    @commentable = extract_commentable.find(params[:commentable_id])
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :create }
      else
        format.html { redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    @commentable = extract_commentable.find(params[:commentable_id])
    @comment = @commentable.comments.find(params[:id])

    if params[:user_id] != current_user.id.to_s
      flash[:error] = "You're not authorized to delete this"
      redirect_to root_url
    else
      respond_to do |format|
        if @comment.destroy
          format.html { redirect_to session.delete(:return_to) }
          format.js { render :destroy }
        else
          format.html { redirect_to session.delete(:return_to) }
          format.js { head :none }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def extract_commentable
    params[:commentable_type].singularize.classify.constantize
  end
end
