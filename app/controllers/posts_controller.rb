class PostsController < ApplicationController
  before_action :require_login, :except => [:index, :show]

  def show
    @user = User.find(params[:user_id])
    @posts =  Post.all.where("posted_id = #{params[:user_id]}").order("created_at DESC")
    @post = Post.new  
  end 


  def create
    @post = Post.new(params_list)
    @post.posted_id = params[:user_id]
    @post.user_id = current_user.id 
    if @post.save
      redirect_to user_posts_path(params[:user_id])
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:user_id])
    posted_id = @post.posted_id
    if @post.destroy
        redirect_to user_posts_path(posted_id)
    else
      flash[:danger] = "There was an error deleting your post, try again."
       redirect_to user_posts_path(posted_id)
    end
  end

  private

  def params_list
      params.require(:post).permit( :body )
  end
end
