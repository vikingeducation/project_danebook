class PostsController < ApplicationController

  def create
    session[:return_to] = request.referer
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if current_user.save
        # flash[:success] = "Created New Post"
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :create }
      else
        # flash[:error] = "Could Not Create Post"
        format.html { redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    @post = current_user.posts.find(params[:id])
    respond_to do |format|
      if @post.destroy
        # flash[:success] = "Deleted Post"
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :destroy }
      else
        # flash[:error] = "Could Not Delete Post"
        format.html { redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end


private

  def post_params
    params.require(:post).permit(:body)
  end

end
