class PostsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  before_action :require_current_author, only: [:destroy]

  def create
    @user = current_user
    @post = @user.posts.build(body: params[:post_body])

    respond_to do |format|
      if @user.save
        flash[:success] = "You created a post"
        format.html { redirect_to user_timeline_path(current_user) }

        format.js
      else
        flash.now[:error] = "Failed to create post"      
        format.html { redirect_to user_timeline_path(current_user) }

        format.js 
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    
    respond_to do |format|
      if current_user.posts.destroy(post)
        flash[:success] = "You successfully destroyed post"
        format.html { redirect_to user_timeline_path(current_user) }
        format.js
      else
        redirect_to :back
      end
    end
  end

  private

    def require_current_author
      @post = Post.find(params[:id])
      unless @post.author == current_user
        flash[:error] = "You are not authorized to delete this post"
        redirect_to current_user
      end
    end
end
