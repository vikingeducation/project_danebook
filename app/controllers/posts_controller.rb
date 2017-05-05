class PostsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:index]

  def index
    @user =  params[:user_id] ? User.find(params[:user_id]) : current_user
    @posts = @user.posts.order('created_at DESC')
    @post = @user.posts.build
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if is_self?
      if @post.save
        flash[:success] = "Yay! Posted."
        redirect_to user_profile_path(@user)
      else
        flash[:error] = "Sorry, but you can't post nothing."
        render :index
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
        flash[:success] = "Your post has been deleted"
        redirect_to user_profile_path(@post.user)
      else
        flash[:error] = "Sorry, we couldn't delete that post"
        render :index
      end
    else
      flash[:error] = "Sorry, you can't do that"
      redirect_to user_profile_path(@user)
    end
  end

  private

  # def reject_unauthorized
  #   unless is_self?
  #     flash[:error] = "Sorry, you're not authorized to do that"
  #     params.delete('action')
  #     return redirect_to user_profile_path(@user)
  #   end
  #   return
  # end

  def post_params
    params.require(:post).permit(:body)
  end
end
