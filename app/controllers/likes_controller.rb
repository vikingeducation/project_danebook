class LikesController < ApplicationController
  def new
    @post_id = params[:post_id]
    @user_id = params[:user_id]
    Like.create(
      :post_id => @post_id,
      :user_id => @user_id
      )
    redirect_to profile_path(current_user.id)
  end
end

