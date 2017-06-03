class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  layout 'timeline'

  def index
    @user =  params[:user_id] ? User.find(params[:user_id]) : current_user
    @posts = @user.posts.order('created_at DESC')
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    fallback = request.origin == root_path ? root_path : user_profile_path(@user)
    if is_self?
      if @post.save
        flash.now[:success] = "Yay! Posted."
        respond_to do |format|
          format.html { redirect_back(fallback_location: fallback) }
          format.js
        end
      else
        flash.now[:error] = "Sorry, but you can't post nothing."
        respond_to do |format|
          format.html { redirect_back(fallback_location: fallback)}
          format.js { render :create_fail }
        end
      end
    else
      flash[:error] = "Sorry, you can only post on your own timeline for now"
      redirect_to user_profile_path(@user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @user = @post.user
    if is_self?
      if @post.destroy
        respond_to do |format|
          format.html { redirect_to user_profile_path(@post.user) }
          format.js
        end
        flash.now[:success] = "Your post has been deleted"
      else
        respond_to do |format|
          format.html {  render :index}
          format.js { render :destroy_fail }
        end
        flash.now[:error] = "Sorry, we couldn't delete that post"
      end
    else
      flash[:error] = "Sorry, you can't do that"
      redirect_to user_profile_path(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
