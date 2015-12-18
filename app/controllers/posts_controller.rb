class PostsController < ApplicationController

  before_action :require_current_user, only: [:create]

  def index
    @user = User.find(params[:user_id]) if params[:user_id]
    @user ||= current_user
    @posts = @user.posts.includes(:likes)
                        .order(created_at: :desc)
    @post = Post.new
    @like = Like.new
  end

  def create
    @post = Post.new(whitelisted_post_params)
    if @post.save
      flash[:success] = "Posted"
      respond_to do |format|
        format.html { redirect_to posts_path(user_id: current_user.id) }
        format.js { render :create_success }
      end
    else
      flash[:error] = "Cannot post this!"
      respond_to do |format|
        format.html { redirect_to posts_path(user_id: current_user.id) }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user && @post.destroy
      flash[:success] = "Deleted"
      respond_to do |format|
        format.html { redirect_to posts_path(user_id: current_user.id) }
        format.js { render :delete_success }
      end
    else
      flash[:error] = "Indestructible"
      respond_to do |format|
        format.html { redirect_to posts_path(user_id: current_user.id) }
      end
    end
  end

  private

  def whitelisted_post_params
    params.require(:post).permit(:user_id, :body)
  end

  def require_current_user
    session[:return_to] = request.referer
    unless params[:post][:user_id] == current_user.id.to_s
      flash[:warning] = "You are not authorized to do this!"
      redirect_to session.delete(:return_to)
    end
  end

end
