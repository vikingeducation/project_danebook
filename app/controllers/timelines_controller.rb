class TimelinesController < ApplicationController
  skip_before_action :correct_user
  before_action :existing_timeline

  def show
    @timeline = Timeline.find(params[:id])
    @user = @timeline.user
    @profile = @user.profile
    @posts = @user.posts
    @post = @posts.build
    @like = Like.new(user_id: current_user.id)
    @comment = Comment.new(user_id: current_user.id)
    @friends = @user.friends
  end

  private
    def existing_timeline
      return true if Timeline.where(id: params[:id].to_i).any?
      flash[:danger] = "Error! Timeline doesn't exist!"
      redirect_to root_url
    end

end
