class LikesController < ApplicationController

  def create
    @likeable = get_likeable_resource
    @likeable.likes.create(user_id: current_user.id)
    redirect_back(fallback_location: root_url)
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_back(fallback_location: root_url)
  end




  private

  def get_likeable_resource
    resource = Post.find(params[:post_id]) if params[:post_id]
    resource = Comment.find(params[:comment_id]) if params[:comment_id]
    resource = Photo.find(params[:photo_id]) if params[:photo_id]
    resource
  end

end
