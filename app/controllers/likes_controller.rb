class LikesController < ApplicationController

  before_action :require_login

  def create
    @like = Like.new({likeable_type: params[:likeable_type],likeable_id: params[:likeable_id], user_id: current_user.id})
    respond_to do |format|
      if @like.save
        format.js
      else
        flash[:alert] = "You already liked this, no need to do it again"
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end

  def destroy
    @like = Like.search_record(params[:likeable_type], params[:likeable_id], current_user.id)
    respond_to do |format|
      if @like
        @like.destroy
        format.js
      else
        flash[:alert] = "You already unliked this, no need to do it again"
        format.js { render "shared/flash" }
      end
      format.html { redirect_to ref }
    end
  end


end
