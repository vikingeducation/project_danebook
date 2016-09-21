class LikesController < ApplicationController

  def create
    id_sym = (params[:likeable].downcase+"_id").to_sym
    @likeable = params[:likeable].constantize.find(params[id_sym])
    @like = @likeable.likes.build(:user_id => current_user.id)
    
    @like.save
    respond_to do |format|
      format.js{}
      format.html do
        if params[:post_id]
          redirect_to user_posts_path(@likeable.user)
        elsif params[:comment_id] && @likeable.commentable_type == "Post"
          redirect_to user_posts_path(@likeable.user)
        elsif params[:comment_id] && @likeable.commentable_type == "Photo"
          redirect_to user_photo_path(@likeable.user, @likeable.id)
        else
          redirect_to user_photo_path(@likeable.user, @likeable.id)
        end
      end
    end
  end

  def destroy
    id_sym = (params[:likeable].downcase+"_id").to_sym
    @likeable = params[:likeable].constantize.find(params[id_sym])
    @like = Like.find(params[:id])
    @like.destroy
    respond_to do |format|
      format.js{}
      format.html do
        if params[:post_id] 
          redirect_to user_posts_path(@likeable.user)
        elsif params[:comment_id] && @likeable.commentable_type == "Post"
           redirect_to user_posts_path(@likeable.user)
        elsif params[:comment_id] && @likeable.commentable_type == "Photo"
          redirect_to user_photo_path(@likeable.user, @likeable.id)
        else
          redirect_to user_photo_path(@likeable, @likeable.id)
        end 
      end
    end
  end

end