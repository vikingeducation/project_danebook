class LikesController < ApplicationController

  def create
    session[:return_to] ||= request.referer

    set_parent
    # set_redirect_destination_user
    @like = @parent.likes.new(user_id: current_user.id)
    if @like.save
      redirect_to session.delete(:return_to)
    else
      flash[:error] = "Something went wrong."
      redirect_to session.delete(:return_to)
    end
  end

  def destroy
    session[:return_to] ||= request.referer

    set_parent
    author = @parent.user
    like = Like.find(params[:id])
    like.destroy
    redirect_to session.delete(:return_to)
  end


  private

  def like_params
    params.require(:likeable).permit(:post_id, :comment_id, :user_id)
  end

  def set_parent
    klass_name = params[:likeable]
    parent_key = params.keys.select{|k| k.match(klass_name.downcase + '_id')}.first

    id = params[parent_key]
    @parent = klass_name.constantize.find(id)
  end


end
