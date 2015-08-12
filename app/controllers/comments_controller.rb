class CommentsController < ApplicationController

  before_action :store_referer
  # before_action :require_object_owner, :only => [:destroy]
  before_action :require_login

  def create
    comment = Comment.new(params_list)
    comment.user_id = current_user.id

    if comment.save
      flash[:success] = "You have commented!"
    else
      flash[:error] = "There was an error, please try again!"
    end

    redirect_to referer
  end

  def destroy
    comment = Comment.find(params[:id])

    if (current_user.id == comment.user_id) && comment.destroy
      flash[:success] = "Your comment was deleted!"
    else
      flash[:error] = "The comment was not deleted."
    end
    redirect_to referer

  end

  private

  def params_list
      params.require(:comment).permit(:body, :id, :user_id,
                        :commentable_type, :commentable_id )
  end
end
