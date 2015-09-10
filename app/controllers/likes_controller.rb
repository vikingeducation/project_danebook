class LikesController < ApplicationController

  before_action :require_login

  def create

    @like = Like.new(likes_params)

    @like.save

    respond_to do |format|
      format.js {render template: 'profiles/likes.js.erb'}
    end

  end

  def destroy
    @like = Like.find(params[:id])
    @likeable = @like.likeable
    @like.destroy
    respond_to do |format|
      format.js {render template: 'profiles/likes.js.erb'}
    end
  end



  def require_login
    unless current_user
      flash[:error] = "You must be logged in"
      redirect_to root_path # halts request cycle
    end
  end

  def likes_params
    {likeable_id: params[:likeable_id], likeable_type: params[:likeable_type],
     user_id: current_user.id}
   end

end
