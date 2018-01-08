class LikesController < ApplicationController

  def create
    set_parent
    @like = @parent.likes.new(user_id: current_user.id)
    if @like.save
      redirect_to user_timelines_path(@parent.user)
    else
      flash[:error] = "Something went wrong."
      redirect_to user_timelines_path(@parent.user)
    end
  end

  def destroy
    set_parent
    post_author = @parent.user
    like = Like.where("user_id = :user_id AND likeable_id = :likeable_id AND likeable_type = :likeable_type", {user_id: current_user.id, likeable_type: params[:likeable], likeable_id: @parent.id}).first
    like.destroy
    redirect_to user_timelines_path(post_author)
  end


  private

  # def like_params
  #   params.require(:likeable).permit(:post_id)
  # end

  def set_parent
    klass_name = params[:likeable]
    parent_key = params.keys.select{|k| k.match(klass_name.downcase + '_id')}.first

    id = params[parent_key]
    @parent = klass_name.constantize.find(id)
  end
end
