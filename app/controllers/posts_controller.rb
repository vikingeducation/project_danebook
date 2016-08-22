class PostsController < ApplicationController

  def create
    session[:return_to] = request.referer
    current_user.posts.build(post_params)
    if current_user.save
      flash[:success] = "Created New Post"
    else
      flash[:error] = "Could Not Create Post"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] = request.referer
    post = current_user.posts.find(params[:id])
    post.delete ? flash[:success] = "Deleted Post" : flash[:alert] = "Did Not Delete Post"
    redirect_to session.delete(:return_to)
  end


private

  def post_params
    params.require(:post).permit(:body)
  end

end
