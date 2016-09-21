class CommentsController < ApplicationController
  before_action :require_login

  def create
    @commentable = comment_parent
    @comment = @commentable.comments.new(description: params[:comment][:description], user_id: current_user.id)
    respond_to do |format|
      if @comment.save!
        flash[:success] = "Comment has been added!"
        format.html { redirect_to :back }
        format.js { }
      else
        flash[:danger] = "Comment not added, returning to the nerdery to diagnose the problem. . . ."
        format.js { head :none }
      end
    end
  end

  def destroy
    if signed_in_user?
      if @comment = Comment.find_by_id(params[:id])
        if @comment.destroy
          flash[:success] = "Comment has been destroyed..."
          redirect_to root_path
        else
          flash[:danger] = "Couldn't destroy the comment, it has gone sentient..."
          redirect_to :back
        end
      else
        flash[:danger] = "Couldn't find the comment. . ."
        redirect_to :back
      end
    else
      redirect_to login_path
    end
  end

  private

    def white_listed_comment_params
      params.require(:comment).permit(:description)
    end

    def comment_parent
      type = params[:comment][:commentable_type].classify
      resource = type.constantize.
                 find_by_id(params[:comment][:commentable_id])
      return nil unless resource
      resource
    end

end
