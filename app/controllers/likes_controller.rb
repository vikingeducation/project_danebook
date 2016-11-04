class LikesController < ApplicationController

  def create
    @likeable = get_likeable_resource
    @like = @likeable.likes.build(user_id: current_user.id)
    respond_to do |format|
      if @like.save
        format.js
        format.html { redirect_back(fallback_location: root_url) }
      else
        format.html { redirect_back(fallback_location: root_url) }
      end
    end
  end

  def destroy
    @like = Like.find(params[:id]).destroy
    respond_to do |format|
      format.js
      format.html { redirect_back(fallback_location: root_url) }
    end
  end




  private

  def get_likeable_resource
    resource = Post.find(params[:post_id]) if params[:post_id]
    resource = Comment.find(params[:comment_id]) if params[:comment_id]
    resource = Photo.find(params[:photo_id]) if params[:photo_id]
    resource
  end

end
