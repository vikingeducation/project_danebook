class Users::PostsController < ApplicationController

  before_action :require_current_user, except: [:index]
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    @post = current_user.posts.build if @user == current_user
  end

  def create
    afdsafdas
  end

end
