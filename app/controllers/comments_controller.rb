class CommentsController < ApplicationController
  before_action :set_post, only: [:show, :create, :edit, :update, :destroy]
  #before_action :set_post_user_profile, only: [:index]
  #before_action :require_login

  def create
    
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment saved!"
      redirect_to user_posts_path(params[:user_id], params[:post_id])
    else
      flash[:alert] = "Post not saved!"
      redirect_to new_user_posts_path(params[:user_id], params[:post_id])
    end
  end  

  # def show

  # end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post_user_profile
    @user = User.find(params[:user_id])
    @profile = @user.profile 
  end
    
  def set_post
    @post = Post.find(params[:post_id])
    @user = @post.user
    @profile = @user.profile
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
