class LikesController < ApplicationController

  before_filter :store_referer

  def create
    @user = current_user
    @type=params[:liking_type].singularize.classify.constantize
    @liking = @type.find(params[:liking_id])
    @id=params[:liking_id]
    @like = Like.new(liking: @liking, user: @user)
    if @like.save
      flash[:success] = "Successfully liked!"
      respond_to do |format|
        format.html {redirect_to referer}
        format.js {render :create_success}
      end
      
    else
      flash.now[:success] = "Failed to like!"
      respond_to do |format|
        format.html {redirect_to referer}
        format.js {render :create_error}
      end
      
    end
  end

  def destroy
    @id = params[:liking_id]
    @like = Like.find_by(user_id: params[:user_id], liking_id: params[:liking_id], liking_type: params[:liking_type].capitalize)
    if @like.destroy
      flash[:error] = "You unliked this post!"
      respond_to do |format|
        format.html {redirect_to referer}
        format.js {render :delete_success}
      end
    else
      flash[:error] = "Can't unlike this post!"
    end
    
  end


end
