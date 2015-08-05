class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = post.likes.new
    unless current_user
      flash[:error] = "Please sign in to Like posts" 
      return redirect_to profile_timeline_path(like.profile)     
    end

    if post.already_liked_by?(current_user)
      return redirect_to profile_timeline_path(like.profile) 
    end

    like.user_id = current_user.id if current_user
    if like.save
      redirect_to profile_timeline_path(like.profile)
    else
      flash[:error] = "Could not like this post. Please try again"
      redirect_to profile_timeline_path(like.profile)
    end
  end
end
