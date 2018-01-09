class LikesController < ApplicationController

  def create
    set_parent
    set_redirect_destination
    @like = @parent.likes.new(user_id: current_user.id)
    if @like.save
      redirect_to user_timelines_path(@redirect_destination)
    else
      flash[:error] = "Something went wrong."
      redirect_to user_timelines_path(@redirect_destination)
    end
  end

  def destroy
    set_parent
    set_redirect_destination
    author = @parent.user
    like = Like.find(params[:id])
    like.destroy
    redirect_to user_timelines_path(@redirect_destination)
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

  def set_redirect_destination
    if @parent.class == Post
      @redirect_destination = @parent.user
    elsif @parent.class == Comment
      @redirect_destination = @parent.commentable.user
    else
    end
  end

end
