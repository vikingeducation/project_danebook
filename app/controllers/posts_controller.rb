class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.where(user_id: current_user.friended_users).or(Post.where(user_id: current_user)).includes(:comments).last(30).reverse
  end
 
  def create
    @post =  current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        flash.now[:success] = "Posted!"
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
      else
        flash.now[:danger] = "Post failed! Did you remeber to include text?"
        format.html {redirect_back(fallback_location: root_path)}
        format.js {redirect_back(fallback_location: root_path)}
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.user_id == current_user.id
        
        format.html {redirect_back(fallback_location: root_path)}
        format.js {}
        @post.destroy
      else
        flash[:danger] = "Bad bad bad!"
        format.html {redirect_back(fallback_location: root_path)}
        format.js {redirect_back(fallback_location: root_path)}
      end
    end
  end

  def post_params
    params.require(:post).permit(:body)
  end


end
