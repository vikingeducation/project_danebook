class PostsController < ApplicationController
  before_action :require_login, :only => [:index]
  before_action :require_current_user, :except => [:index]

  def index
    @user = User.find_by_id(params[:user_id])
    if @user
      @posts = Post.where(:user_id => @user.id)
      @posts.order(:created_at => 'DESC')
    else
      redirect_to_referer(
        root_path,
        :flash => {:error => 'User not found'}
      )
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'Post created'
    else
      flash[:error] = 'Post not created: ' +
        @post.errors.full_messages.join(', ')
    end
    redirect_to_referer user_posts_path(current_user)
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post && @post.destroy
      flash[:success] = 'Post destroyed'
    else
      flash[:error] = 'Post not destroyed'
    end
    redirect_to user_posts_path(current_user)
  end


  private
  def post_params
    params.require(:post)
      .permit(
        :body,
        :user_id
      )
  end
end
