class PostsController < ApplicationController

  def index
    @user = current_user
    @posts = Post.where(author_id: @user.friends.pluck(:id) << current_user.id).
                        includes(author: [profile: :photo],
                        likes: :liker,
                        comments:
                        [:commentable,
                        author: [profile: :photo],
                        likes: :liker]).
                        order(created_at: :desc)
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
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to user_path(@user)
    else
      flash[:error] = "Something went wrong when deleting the post"
      redirect_to user_path(@user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
