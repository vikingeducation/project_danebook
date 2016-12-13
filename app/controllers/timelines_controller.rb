class TimelinesController < ApplicationController

  before_action :require_login, :except => [:show ]

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @post = Post.new
    @post.user_id = current_user.id
  end




end
