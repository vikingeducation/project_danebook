class CommentsController < ApplicationController
  def create
    session[:return_to] ||= request.referer
    @comment = commentable.comments.build(author_id: current_user.id, content: comment_params[:content])
    @parent_class = @comment.commentable.class.name.downcase

    respond_to do |format|
      if @comment.save
        format.html { redirect_to session.delete(:return_to), notice: "Commented" }
        format.js { render :create, status: :created }
      else
        format.html { redirect_to session.delete(:return_to), notice: "An error occurred" }
        format.js { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment = current_user.comments.find(params[:id])

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: "Comment deleted" }
      format.js { render :destroy, status: 200 }
    end
  end

  private

  def parent_id
    "#{params[:commentable].to_s}_id".downcase.to_sym
  end

  def commentable
    # use the params to find the appropriate model and object
    params[:commentable].capitalize.constantize.find(params[parent_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
