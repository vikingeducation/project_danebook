class LikesController < ApplicationController


  def create
    session[:return_to] ||= request.referer

    like = Like.new(params_list)
    like.user_id = current_user.id
    if like.save
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error has occurred"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    
    if current_user.id == like.user_id && like.destroy
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "An error has occurred"
    end
    redirect_to session.delete(:return_to)
  end

  private

  def like_params_list
      params.require(:like).permit(:duty_id , :duty_type, :user_id, :id)
  end

end
