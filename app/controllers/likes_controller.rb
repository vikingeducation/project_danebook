class LikesController < ApplicationController

  before_action :store_referer

  def create
    like = Like.new(params_list)
    like.user_id = current_user.id
    if like.save
      flash[:success] = "You have liked this!"
    else
      flash[:error] = "There was an error, please try liking again!"
    end
    redirect_to referer
  end

  def destroy
    like = current_user.match_like(params_list)
    if current_user.id == like.user_id && like.destroy
      flash[:success] = "You have unliked this!"
    else
      flash[:error] = "There was an error, please try again!"
    end
    redirect_to referer
  end

  # def show
  #   @likes = Like.recent_likes(extract_likings)
  # end


  private

  def params_list
      params.require(:like).permit(:likings_type, :likings_id, :method, :id)
  end

end
