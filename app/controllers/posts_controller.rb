class PostsController < ApplicationController

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    if @user.save
      flash.notice = "Post created."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js
      end
    else
      flash.notice = "Error. Post not created."
      respond_to do |format|
        format.html { redirect_back(fallback_location: current_user) }
        format.js
      end 
    end
  end

  def destroy
    @user = current_user
    @post = @user.posts.find(params[:id])
    if @post.destroy
      flash.notice = "Post deleted."
      respond_to do |format|
        format.html {redirect_to user_path(@user)}
        format.js
      end
    else
      flash.notice = "Error. Post not deleted."
      respond_to do |format|
        format.html {redirect_to user_path(@user)}
        format.js
      end
    end
  end

  def cfield
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html {}
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

end
