class LikesController < ApplicationController

  before_action :require_login, :only => [:create, :destroy]

  def create
    session[:return_to] ||= request.referer
    # like = Like.new(params_list)
    like = Like.new(extract_likings)
    like.user_id = current_user.id
    fail
    if like.save
      # fail
      flash[:success] = "You have liked this!"
    else
      flash[:error] = "There was an error, please try liking again!"
    end
    redirect_to session.delete(:return_to)
  end

  def destroy
    session[:return_to] ||= request.referer
    @like = current_user.likes
    if @like.save
      # fail
      flash[:success] = "You have liked this!"
    else
      flash[:error] = "There was an error, please try liking again!"
    end
    redirect_to session.delete(:return_to)
  end

  def show
    @likes = Like.recent_likes(extract_likings)
  end

  # def index
  #   @likes = extract_likings.likes

  # end

  private

  # def params_list
  #     params.require(:likes).permit(:likings_type, :likings_id, :method, :id)
  # end

  def extract_likings
    likings_type, likings_id = request.referrer.split('/')[3,4]
    # resource, id = request.path.split('/')[1,2]
    likings_type.singularize.classify.constantize.find(likings_id)
  end
end
