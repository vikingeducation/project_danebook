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

  def destroy #WIP AF

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
