class Comments::LikesController < ApplicationController
  def create
    comment = Comment.find(params[:comment_id])
    like = comment.likes.new

    like.user_id = current_user.id if current_user
    if like.save
      redirect_to request.referrer
    else
      flash[:error] = "Could not like this comment. Please try again"
      redirect_to request.referrer
    end
  end
end
