class LikesController < ApplicationController

  def create
    session[:return_to] = request.referer
    @likeable = extract_likeable.find(params[:likeable_id])
    @like = @likeable.likes.build(user_id: current_user.id)
    respond_to do |format|
      if @like.save
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :create }
      else
        format.html { redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end

  def destroy
    session[:return_to] = request.referer
    @likeable = extract_likeable.find(params[:likeable_id])
    @like = @likeable.likes.find_by user_id: current_user.id
    respond_to do |format|
      if @like.destroy
        format.html { redirect_to session.delete(:return_to) }
        format.js { render :destroy }
      else
        format.html { redirect_to session.delete(:return_to) }
        format.js { head :none }
      end
    end
  end

  private

  def extract_likeable
    params[:likeable_type].singularize.classify.constantize
  end
end
