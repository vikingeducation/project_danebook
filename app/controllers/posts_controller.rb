class PostsController < ApplicationController

  def index
    @posts = Post.all_friend_posts(current_user) + Post.where(author: current_user)
    @post = Post.new
  end

  def create
    @post = current_user.authored_posts.build(post_params)
    if @post.save
      flash.now[:success] = "Nice post chum!"
      respond_to do |f|
        f.js { render :create_success }
        f.html { go_back }
      end
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      go_back
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    if @post.destroy
      flash[:success] = "We nuked it dawg! It is gone!"
      go_back
    else
      flash[:error] = "Oops! Something went wrong. Our apes are researching this problem as we speak."
      go_back
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :id, :author_id)
  end

end
