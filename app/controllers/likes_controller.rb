class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.liker_id = current_user.id
    if @like.save
      flash[:notice] = "Like successfully created"
      redirect_to :back
    else
      flash[:notice] = "like has failed"
      redirect_to :back
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      flash[:success] = "Your like has been deleted!"
    else
      flash[:error] = "Error! The like lives on!"
    end
    redirect_to :back

  end

  def like_params
    params.permit(:likable_id, :likable_type)
  end
end
