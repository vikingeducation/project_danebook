class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build
    @like.user = current_user

    if @like.save
      flash[:success] = "Cool, you liked it."
    else
      flash[:error] = @like.errors.full_messages.join(", ")
    end
    redirect_to user_timeline_path(@post.author)
  end


end
