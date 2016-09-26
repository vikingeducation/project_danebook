class LikingsController < ApplicationController

  def index
    redirect_to user_path(current_user)
  end

  def create
    @post = Post.find(params[:post_id])
    @post.likes.create(user_id: current_user.id)
    
    respond_to do |format|
      format.js { }
    end
  end

  def destroy
    @liking = Liking.find(params[:id])
    @post = @liking.likeable
    @user = @liking.user
    if @liking.destroy
      respond_to do |format|
        # format.html { render(:text => "not implemented") }
        format.js { }
      end    
    else
      redirect_to user_path(current_user)
    end
  end
end
