class LikesController < ApplicationController
  def new
    @post_id = params[:post_id]
    @user_id = params[:user_id]
    Like.create(
      :post_id => @post_id,
      :user_id => @user_id
      )
    redirect_to user_profile_path(params[:liking_person].to_i)
  end

  def destroy
    @like = Like.find(params[:id].to_i)
    @like.destroy
    redirect_to user_profile_path(params[:original_man].to_i)
  end
end

