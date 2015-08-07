class LikesController < ApplicationController

  before_action :require_login

  def create
    @liker = current_user
    @liked = Post.find(params[:liked_id])
    if @liker.liked_posts << @liked
      flash[:success] = 'Post liked!'
    else
      flash[:danger] = 'Error!'
    end
    redirect_to :back
  end


  def destroy
    if Like.find(params[:id]).destroy
      flash[:success] = 'Post unliked!'
    else
      flash[:danger] = 'Error!'
    end
    redirect_to :back
  end

end
