class PostsController < ApplicationController

	before_action :require_signed_in, only: [:show, :index]
	before_action :require_current_user, only: [:new, :update, :edit, :destroy]

	# before_action :require_post_author, :only => [:new, :edit, :update, :destroy]
	# Index and new are ghetto: if the user is the current user they will be see 'new'
	# if they are not, they will see 'index'.
	def index
		if current_user?
			redirect_to new_user_post_path
		else
			@user = User.find(params[:user_id])
			@friends = @user.friended_users
			@posts = @user.posts.order('created_at DESC')
			@photos = @user.photos
		end
	end

	def new
		@user = current_user
		@post = Post.new
		@friends = @user.friended_users
		@posts = @user.posts.order('created_at DESC')
		@photos = @user.photos
	end

	def create
		@user = current_user
		@posts = @user.posts

		@post = current_user.posts.build(post_params)
		if @post.save
		  redirect_to new_user_post_path
		else
		  flash.now[:error] = "NO NO NO! SECURITY!!! The police are on their way."
		  render :new
		end
	end

	def show
	  @post = Post.find(params[:id])
	end

	def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(whitelisted_post_params)
      flash[:success] = "Yay! You've updated your post successfully!"
      redirect_to @post
    else
      flash.now[:error] = "Boo! We couldn't update the post because it had errors." 
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Good thing that embarassment is gone!"
      redirect_to user_posts_path
    else
      flash[:error] = "Apparently, #{current_user.name} broke everything."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :photo, :is_photo, :body)
  end

  # not currently used. The idea is to stop XSS by only allowing posts from current_user
	def require_post_author
		unless params[:user_id] && current_user.post_ids.include?(params[:user_id].to_i)
		  flash[:error] = "Don't... Don't..."
		  redirect_to root_url
		end
	end
end
