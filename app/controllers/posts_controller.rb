class PostsController < ApplicationController

  def index
    @user = current_user
    @posts = Post.where(author_id: @user.friends.pluck(:id) << current_user.id).include_post_info.order(created_at: :desc)
    @post = current_user.posts.build
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
