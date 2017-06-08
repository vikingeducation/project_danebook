class LikesController < ApplicationController
  before_action :set_likable

  def create
    @like = @likable.likes.build(user_id: current_user.id)
    if @like.save
      flash[:success] = "#{@like.likable_type} liked"
    else
      flash[:danger] = "Failed to like #{@like.likable_type}"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = @likable.likes.find(params[:id])
    if like.delete
      flash[:success] = "#{like.likable_type} unliked"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def set_likable
    cls = params[:likable].constantize
    likable_key = (params[:likable].downcase + "_id").to_sym
    @likable = cls.find(params[likable_key])
  end

end
