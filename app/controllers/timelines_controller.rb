class TimelinesController < ApplicationController

  def show
    @new_post = Post.new(:user_id => current_user.id)
    @comment = Comment.new
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @posts = Post.where(:user_id => @user.id).order(:created_at => :desc)
  end
end
