class LikesController < ApplicationController



  def create
    like = Like.new(like_params)

    unless like.save
      flash[:danger] = "Could not be liked."
    end

    redirect_to URI(request.referer).path
  end

  def destroy
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likable_type)
  end

end
