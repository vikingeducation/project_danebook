class PostsController < ApplicationController
  before_action :require_current_user, :only => [:edit, :update, :destroy]
  before_action :set_user, :only => [:destroy, :edit, :update, :show ]

  def index

    @users = User.all
    if @user && @user.authenticate(params[:password])
      sign_in(@user)
    else
      flash.now[:error] = "Please sign up or sign in"
      render :index
    end
  end

  def show
  end

  def new
    @user = current_user
    @new_post = @user.build_post
  end

  def edit
    require_current_user
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save    
      sign_in(@user)
      flash[:success] = "created new user!"
      redirect_to user_profile_path(current_user.id)
    else
      flash.now[:error] = "There was an error"
      redirect_to user_profile_path(current_user.id)
    end
  end

  def update
    if params[:post][:comment]
      Comment.create(
      :content => params[:post][:comment][:content],
      :post_id => params[:id].to_i,
      :user_id => current_user.id
      )
      working_user = Post.find(params[:id].to_i).receiver.id
      redirect_to user_profile_path(working_user)
    else
      @user = current_user
      if post_it
        flash[:success] = "Successfully updated"
      else
        flash.now[:failure] = "failed to update"
        render :edit
      end   
      # HACK ALERT; I DO NOT KNOW WHY BUT I HAVE TO ADD ONEPost

      working_user = Post.find((params[:id].to_i + 1)).user.id

      redirect_to user_profile_path(working_user)
    end    
  end

  def destroy
    @post = Post.find(params[:id].to_i)
    @post.destroy
    redirect_to user_profile_path(current_user.id)
  end

  private

  def set_user
    @user = current_user
  end

  def post_params
    params.
      require(:post).
      permit(:content,
             :user_id,
             { :comment_attributes => [
              :content ] } )
  end
end
