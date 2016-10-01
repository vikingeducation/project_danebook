class LikesController < ApplicationController

  def create

  end


  private
  def whitelisted_likes_params
    params.require(:like).permit(:user_id, :post_id)
  end

end
