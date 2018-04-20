class LikesController < ApplicationController

  def create
    @parent = set_parent

    like = @parent.likes.new(user_id: current_user.id)

    if like.save
      respond_to :js
    else
      flash[:error] = "Something went wrong."
    end
  end

  def destroy
    @parent = set_parent

    like = Like.find(params[:id])
    like.destroy
  end


  private

  def like_params
    params.require(:likeable).permit(:post_id, :comment_id, :user_id)
  end

  def set_parent
    klass_name = params[:likeable]
    parent_key = params.keys.select{|key| key.match(klass_name.downcase + '_id')}.first

    id = params[parent_key]
    klass_name.constantize.find(id)
  end


end
