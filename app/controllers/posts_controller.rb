class PostsController < ApplicationController

  def index
    @user = current_user
    @posts = Post.friends_posts(@user).include_post_info.order(created_at: :desc).paginate(:page => params[:page], :per_page => 16)
    @post = current_user.posts.build
    @popular_week = Post.recently_popular(@user, 7.days)
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @user = @post.author

    respond_to do |format|
      if @post.save
        format.html { redirect_to @user, notice: "Status updated" }
        format.js { render :create, status: :created, location: @post }
      else
        format.html { redirect_to @user, notice: "Something went wrong with your post" }
        format.js { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @user = @post.author

    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: "Post deleted" }
      format.js { render :destroy, status: 200 }
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
