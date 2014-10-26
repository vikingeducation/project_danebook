class PostsController < ApplicationController
  def new
    @user = User.find(params[:id])

    @hometown = Location.get_location(@user.location_id).to_s if @user.location_id
    @current = Location.get_location(@user.current_location_id).to_s if @user.current_location_id
    
    #@posts means all posts and @post means creating a new post:
    @posts=@user.posts
    @post = Post.new



    
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Posted!"
      redirect_to timeline_path(@post.user_id)
    else
      flash[:error] = "Error, please try again"
      render 'new'
    end
  end

  def destroy
   @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Post successfully deleted."
      redirect_to timeline_path(params[:user_id])
    else
      redirect_to timeline_path(params[:user_id])
    end
  end

  private

  def post_params
    params.require(:post)
    .permit(:content, :user_id)
  end

end
