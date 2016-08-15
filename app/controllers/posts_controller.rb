class PostsController < ApplicationController
  before_action :require_current_user, only: [:destroy, :create]
  before_action :set_user, only: [:create, :destroy]


  def create
    @post = @user.posts.build(post_params)
    @post.from = current_user.id
    if @post.save
      flash[:success] = "Your post as been successfully posted for all to see!"
      redirect_to @user
    else
      flash[:danger] = "You post was not posted"
      redirect_to current_user
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @post.destroy
    redirect_to current_user
  end


  private

  def post_params
    params.require(:post).permit(:content, :from, comments_attributes: [:content], :commentable, :post_id)
  end

end
