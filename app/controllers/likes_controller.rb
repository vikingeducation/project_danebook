class LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id]).likes.new
    post.user_id = current_user.id
    


  end
end
