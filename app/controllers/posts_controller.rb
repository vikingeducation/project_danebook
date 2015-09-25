class PostsController < ApplicationController

  before_action :require_current_user, :except => [:index]


  def index
    set_assigns(params[:user_id])
    @new_post = current_user.posts.build if signed_in_user?
  end


  def create
    @new_post = current_user.posts.build(post_params)

    if @new_post.save
      flash[:success] = "New post created!"

      respond_to do |format|
        format.html { redirect_to [current_user, :posts] }
        format.js { render :create_success, :status => 200 }
      end

    else
      flash.now[:danger] = "New post not saved. Please try again."

      respond_to do |format|
        format.html do
          set_assigns(params[:user_id])
          render :index
        end
        format.js { render :nothing => true, :status => 400 }
      end

    end
  end


  def destroy
    if Post.find(params[:id]).destroy!
      flash[:success] = 'Post deleted!'
    else
      flash[:danger] = "Sorry, we couldn't delete your post. Please try again."
    end
    redirect_to user_posts_path(current_user)
  end


  private

    def set_assigns(user_id)
      @user = User.find(user_id)
      @posts = @user.posts.order(:created_at => :desc)
      @friends = @user.friended_users.sample(6)
      @photos = @user.photos.sample(9)
    end


    def post_params
      params.require(:post).permit(:body)
    end


    def require_current_user
      unless params[:user_id] == current_user.id.to_s
        flash[:danger] = "You're not authorized to do this!"
        redirect_to user_posts_path(params[:user_id])
      end
    end

end
