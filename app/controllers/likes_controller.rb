class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(likes_params)

    if !Like.already_liked?(@post, current_user) && @like.save!  
      flash[:success] = "You have liked that comment"
      redirect_to current_user
    else
      flash[:danger] = "You already liked the comment"
      redirect_to current_user
    end
  end

  def destroy
  end


  def likes_params
    params.require(:like).permit(:user_id)
  end 
end
