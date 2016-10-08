class LikesController < ApplicationController
  before_action :require_login

  def create
    type = params[:likeable_type].capitalize
    @resource = type.constantize.find(params[:likeable_id])

    respond_to do |format|
      if @resource.likes.create(:user_id => current_user.id)
        flash[:success] = "Like contributed to the post!"
        format.html { redirect_to :back }
        format.js { }
      else
        flash[:danger] = "Couldn't establish the like"
        format.html { redirect_to :back }
        format.js { head :none }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    type = params[:likeable_type].capitalize
    @resource = type.constantize.find(params[:likeable_id])
    respond_to do |format|
      if @like.destroy
        flash[:success] = "Unliked the post"
        format.html { redirect_to :back }
        format.js { render 'create' }
      else
        flash[:danger] = "Couldn't make the unlike"
        format.html { redirect_to :back }
        format.js { head :none }
      end
    end
  end
end
