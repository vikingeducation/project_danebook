class PostsController < ApplicationController

  before_action :require_current_user, :only => [:create, :destroy]

  def new
    @user = User.find(params[:user_id])    
    @posts = @user.posts
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save!
      flash[:success] = "Post successful. Now you have to live with it"
      redirect_to user_timeline_path(current_user)
    else
      flash[:error] = "Post failed. Consider this a lifeline"
      render :new
    end
  end

  def destroy
   @post = current_user.posts.find(params[:id])
    if @post.destroy!
      flash[:success] = "You deleted that post! Whew! Let's hope no one took a screen shot."
      redirect_to user_timeline_path(current_user)
    else
      flash[:error] = "That....that didn't work. Try again."
      redirect_to user_timeline_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:post_body, :user_id)
  end

end