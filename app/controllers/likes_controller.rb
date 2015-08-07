class LikesController < ApplicationController

  before_action :require_login

  def create
    @liked = Post.find(params[:post_id])
    if @liked.likers << current_user
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
