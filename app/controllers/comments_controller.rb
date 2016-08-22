class CommentsController < ApplicationController
  before_action :require_login

  def create
    if signed_in_user?
      if instance = comment_parent
        if instance.save!
          flash[:success] = "Comment has been added!"
        else
          flash[:error] = "Comment not added, returning to the nerdery to diagnose the problem. . . ."
        end
      else
        flash[:error] = "Could not find #{params[:comment][:commentable_type].downcase}"
      end
      redirect_to :back
    else
      redirect_to login_path
    end
  end

  def destroy
    if signed_in_user?
      if @comment = Comment.find_by_id(params[:id])
        if @comment.destroy
          flash[:success] = "Comment has been destroyed..."
          redirect_to root_path
        else
          flash[:error] = "Couldn't destroy the comment, it has gone sentient..."
          redirect_to :back
        end
      else
        flash[:error] = "Couldn't find the comment. . ."
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
      resource.comments.new(description: params[:comment][:description], user_id: current_user.id)
    end

end
