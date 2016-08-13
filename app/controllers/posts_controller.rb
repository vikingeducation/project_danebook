class PostsController < ApplicationController
  skip_before_action :correct_user

  def create
    @user = current_user
    @posts = @user.posts
    @post = @posts.create!(post_params)
    redirect_to @user.timeline
  end

  def update
    @post = Post.find(params[:id])
    @user = @post.user
    @post.update(post_params)
    redirect_to @user.timeline
  end

  private
    def post_params
      params.require(:post).permit(:body, 
                                   :user_id,
                                   { comments_attributes: [:body] },
                                   { :likes_attributes })
    end
end
