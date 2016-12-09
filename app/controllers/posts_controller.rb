class PostsController < ApplicationController

  include UserCheck

  before_action :set_user
  before_action :correct_user, except: [:show]

  def create
    @post = @user.posts.build(body: params[:post][:body], post_type: "Post")
    if @post.save
      flash[:success] = ["Profile Created"]
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:danger] = ["Something went wrong.."]
      @post.errors.full_messages.each do |error|
        flash.now[:danger] << error
      end
      render :new
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
  end

end
