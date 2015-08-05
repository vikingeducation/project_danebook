class PostsController < ApplicationController

  def create
    @user = User.find(params[:post][:user_id])
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post successfully submitted"
    else
      flash[:error] = @post.errors.full_messages.first
    end
    redirect_to user_timeline_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy
    flash[:alert] = "Your post was deleted!"
    redirect_to user_timeline_path(@user)
  end


  private

  def post_params
    params.require(:post).permit(:body, :recipient_user_id)
  end

end
