class LikesController < ApplicationController

  before_action :set_return_path, only: [:create, :destroy]

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = "Liked!"
    else
      flash[:error] = "Something went wrong."
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if @like.destroy
      flash[:success] = "Unliked."
    else
      flash[:error] = "Somethign went wrong."
    end
    redirect_to session.delete(:return_to)
  end

  private

    def like_params
      params.require(:like).permit(:likable_type, :likable_id)
    end
end
