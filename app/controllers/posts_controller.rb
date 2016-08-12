class PostsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.create!(post_params)
    @user.posts << @post
    redirect_to user_timelines_path(id: @post.user_id)
  end

  def edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    @post.update_attributes(title: post_params[:title], body: post_params[:body])
    if post_params[:like]
      @post.likes << Like.new
    end
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:user_id,:title,:body,:like)
    end

    def set_post
      case action_name
      when 'show'
        @user = Post.find_by_id(params[:id])
      when 'edit', 'update', 'destroy'
        @user = current_user
      end
      redirect_to_referer root_path, :flash => {:error => 'Unable to find that post'} unless @post
    end
end
