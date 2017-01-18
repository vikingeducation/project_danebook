class PostsController < ApplicationController

  include UserCheck

  before_action :set_user
  before_action :correct_user, except: [:show, :index]

  def index
    if(params[:start_id] != "last")
      @posts = @user.posts.order(created_at: :desc).where("post_type='Post' AND id < ?", params[:start_id]).limit(10)
    else
      @posts = @user.posts.order(created_at: :desc).where(post_type: "Post").limit(10)
    end
  end

  def create
    @post = @user.posts.build(whitelisted)
    if @post.save
      flash[:success] = ["Profile Created"]
      respond_to do |format|
        format.js
        format.html {redirect_to user_post_path(@user, @post)}
      end
    else
      respond_to do |format|
        format.js do
          @status = :danger
          @msg = ["Something went wrong.."]
          @post.errors.full_messages.each do |error|
            @msg << error
          end
          render template: 'shared/flashes'
        end
        format.html do
          flash.now[:danger] = ["Something went wrong.."]
          @post.errors.full_messages.each do |error|
            flash.now[:danger] << error
          end
          render :new
        end
      end
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      if(@post.post)
        flash[:success] = ["Comment deleted."]
      else
        flash[:success] = ["Post deleted."]
      end
      @post.destroy
    else
      flash[:danger] = ["Post not found."]
    end
    redirect_to root_path
  end

  private

    def whitelisted
      params.require(:post).permit(:body).merge(post_type: "Post")
    end

end
