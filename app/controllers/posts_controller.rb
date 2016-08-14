class PostsController < ApplicationController
  skip_before_action :correct_user
  before_action :correct_post, only: [:update]
  before_action :correct_timeline, only: [:create]

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
                                   { comments_attributes: [:user_id,:body] },
                                   { likes_attributes: [:user_id,:_destroy] })
    end
end
