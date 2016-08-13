class LikesController < ApplicationController

  def create

    likable = get_likable

    if likable
    # TODO: check to see if it's already liked
    # unless Like.find_by(user_id: current_user.id, likable_id: 11)
      like = likable.likes.build
      current_user.likes << like

      unless like.save
        flash[:danger] = "Could not be liked."
      end
    else
      flash[:danger] = "Could not be liked."
    end

    redirect_to URI(request.referer).path
  end

  def destroy
    like = current_user.likes.find(params[:id])

    unless like.destroy
      flash[:danger] = "Could not be unliked!"
    end

    redirect_to URI(request.referer).path
  end

  private

  def get_likable
    if params[:likable] == 'Post'
      return Post.find(params[:post_id])
    elsif params[:likable] == 'Comment'
      return Comment.find(params[:comment_id])
    end
  end

end
