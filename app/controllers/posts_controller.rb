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
    if @post.save
      flash[:success] = "Status updated"
      redirect_to @user
    else
      flash[:error] = "Something went wrong with your post"
      redirect_to @user
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
